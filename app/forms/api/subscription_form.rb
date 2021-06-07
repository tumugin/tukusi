class Api::SubscriptionForm
  include ActiveModel::Model

  attr_accessor :id, :enabled, :check_interval_seconds, :target_url,
                :target_selector, :subscription_type, :admin_user,
                :notify_target_ids

  validates :id, numericality: { only_integer: true }, allow_nil: true
  validates :enabled, inclusion: { in: [true, false] }
  validates :check_interval_seconds, numericality: true
  validates :target_url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :target_selector, presence: true, if: :needs_target_selector_check?
  validates :subscription_type, presence: true, inclusion: { in: Subscription::SUBSCRIPTION_TYPES }
  validates :admin_user, presence: true, if: :needs_admin_user_check?
  validates :notify_target_ids, presence: true

  def needs_admin_user_check?
    !id.nil?
  end

  def needs_target_selector_check?
    [
      Subscription::SUBSCRIPTION_TYPE_JSON,
      Subscription::SUBSCRIPTION_TYPE_NOKOGIRI,
    ].include?(subscription_type)
  end

  def save!
    validate!

    if id.nil?
      subscription = Subscription.new
      subscription.admin_user = admin_user
    else
      subscription = Subscription.find(id)
    end

    notify_targets = NotifyTarget.find(notify_target_ids)
    subscription.assign_attributes(
      enabled: enabled,
      check_interval_seconds: check_interval_seconds,
      target_url: target_url,
      target_selector: target_selector,
      subscription_type: subscription_type,
      notify_targets: notify_targets
    )

    subscription.save!
    subscription
  end
end
