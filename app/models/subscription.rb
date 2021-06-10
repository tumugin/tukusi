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
    joins('LEFT OUTER JOIN (SELECT `crawl_logs`.`subscription_id`, MAX(`crawl_logs`.`started_at`) AS `started_at` FROM `crawl_logs` GROUP BY `crawl_logs`.`subscription_id`) AS `crawl_logs` ON `crawl_logs`.`subscription_id` = `subscriptions`.`id`')
      .where('`crawl_logs`.`started_at` IS NULL')
      .or(where('TIME_TO_SEC(TIMEDIFF(?, `crawl_logs`.`started_at`)) >= subscriptions.check_interval_seconds', Time.current))
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
end
