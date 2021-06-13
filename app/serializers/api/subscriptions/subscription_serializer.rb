class Api::Subscriptions::SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :enabled, :check_interval_seconds, :target_url,
             :target_selector, :subscription_type, :timeout_seconds, :admin_user_id
  has_many :notify_targets
end
