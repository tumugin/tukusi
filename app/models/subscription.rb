class Subscription < ApplicationRecord
  belongs_to :admin_user
  has_many :crawl_logs, dependent: :destroy
  has_many :latest_crawl_logs, -> { order(id: :desc) }, class_name: 'CrawlLog'
  has_many :notify_targets_of_subscriptions
  has_many :notify_targets, through: :notify_targets_of_subscriptions

  scope :enabled, -> {
    where(enabled: true)
  }
  scope :needs_crawl, -> {
    joins(:latest_crawl_logs).where('TIME_TO_SEC(DATEDIFF(?, latest_crawl_logs.ended_at)) > subscriptions.check_interval_seconds', Time.current)
  }

  SUBSCRIPTION_TYPE_NOKOGIRI = 'nokogiri'
  SUBSCRIPTION_TYPE_PLAIN = 'plain'
  SUBSCRIPTION_TYPE_JSON = 'json'

  SUBSCRIPTION_TYPES = [
    SUBSCRIPTION_TYPE_NOKOGIRI,
    SUBSCRIPTION_TYPE_PLAIN,
    SUBSCRIPTION_TYPE_JSON,
  ]

  def latest_crawl_log
    latest_crawl_logs.take
  end
end
