class Subscription < ApplicationRecord
  belongs_to :admin_user
  has_many :crawl_logs
  has_many :notify_targets_of_subscriptions
  has_many :notify_targets, through: :notify_targets_of_subscriptions

  SUBSCRIPTION_TYPE_NOKOGIRI = 'nokogiri'
  SUBSCRIPTION_TYPE_PLAIN = 'plain'
  SUBSCRIPTION_TYPE_JSON = 'json'

  SUBSCRIPTION_TYPES = [
    SUBSCRIPTION_TYPE_NOKOGIRI,
    SUBSCRIPTION_TYPE_PLAIN,
    SUBSCRIPTION_TYPE_JSON,
  ]
end
