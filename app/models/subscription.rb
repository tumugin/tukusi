class Subscription < ApplicationRecord
  belongs_to :admin_user

  has_many :crawl_logs, dependent: :destroy
  has_many :latest_crawl_logs, -> { order(id: :desc) }, class_name: 'CrawlLog'
  has_one :latest_crawl_log, -> { order(id: :desc) }, class_name: 'CrawlLog'

  has_many :notify_targets_of_subscriptions
  has_many :notify_targets, through: :notify_targets_of_subscriptions

  scope :enabled?, -> {
    where(enabled: true)
  }
  scope :needs_crawl?, -> {
    # 最悪なクエリだなおい
    joins('
      LEFT OUTER JOIN (
        SELECT
          `crawl_logs`.`subscription_id`,
           MAX(`crawl_logs`.`started_at`) AS `started_at`
        FROM `crawl_logs`
        GROUP BY `crawl_logs`.`subscription_id`
      ) AS `crawl_logs`
      ON
        `crawl_logs`.`subscription_id` = `subscriptions`.`id`
    ')
      .where('`crawl_logs`.`started_at` IS NULL')
      .or(where('TIME_TO_SEC(TIMEDIFF(?, `crawl_logs`.`started_at`)) >= `subscriptions`.`check_interval_seconds`', Time.current))
  }

  SUBSCRIPTION_TYPE_NOKOGIRI = 'nokogiri'
  SUBSCRIPTION_TYPE_PLAIN = 'plain'
  SUBSCRIPTION_TYPE_JSON = 'json'

  SUBSCRIPTION_TYPES = [
    SUBSCRIPTION_TYPE_NOKOGIRI,
    SUBSCRIPTION_TYPE_PLAIN,
    SUBSCRIPTION_TYPE_JSON,
  ]

  def needs_crawl?
    latest_crawl_log.nil? || (Time.current - latest_crawl_log.started_at).seconds > check_interval_seconds
  end

  def has_update?
    latest_two_updates = latest_crawl_logs
                           .where(result: CrawlLog::RESULT_SUCCESS)
                           .limit(2)
    first = latest_two_updates[0]
    second = latest_two_updates[1]
    first&.captured_data != second&.captured_data
  end

  def notify!
    latest = latest_crawl_log
    notify_targets.find_each do |notify_target|
      notify_target.notify!(
        message: "「#{name}」が更新されました！\n#{target_url}",
        attachment_title: "更新通知: #{name}",
        attachment_message: "巡回URL: #{target_url}\n巡回時刻: #{latest.started_at}\n巡回にかかった秒数: #{latest.duration}sec"
      )
    end
  end

  def execute_crawl!
    case subscription_type
    when Subscription::SUBSCRIPTION_TYPE_NOKOGIRI then
      return Crawler::NokogiriCrawler.new(
        url: target_url,
        selector: target_selector,
        timeout_seconds: timeout_seconds
      ).perform!
    when Subscription::SUBSCRIPTION_TYPE_PLAIN then
      return Crawler::PlainCrawler.new(
        url: target_url,
        timeout_seconds: timeout_seconds
      ).perform!
    when Subscription::SUBSCRIPTION_TYPE_JSON then
      return Crawler::JsonCrawler.new(
        url: target_url,
        selector: target_selector,
        timeout_seconds: timeout_seconds
      ).perform!
    else
      raise '未実装のクローラーです'
    end
  end

  def perform_crawler_job_later
    SubscriptionCrawlerJob.perform_later(id)
  end
end
