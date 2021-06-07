class Api::SubscriptionForm
  include ActiveModel::Model

  attr_accessor :id, :enabled, :check_interval_seconds, :target_url,
                :target_selector, :subscription_type, :admin_user

  validates :id, numericality: { only_integer: true }, allow_nil: true
  validates :enabled, inclusion: { in: [true, false] }
  validates :check_interval_seconds, numericality: true
  validates :target_url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :target_selector, presence: true, if: :needs_target_selector_check?
  validates :subscription_type, presence: true, inclusion: { in: Subscription::SUBSCRIPTION_TYPES }
  validates :admin_user, presence: true, if: :needs_admin_user_check?

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
    if id.nil?
      subscription = Subscription.new
    else
      subscription = Subscription.find(id)
    end
    subscription.assign_attributes(
      enabled: enabled,
      check_interval_seconds: check_interval_seconds,
      target_url: target_url,
      target_selector: target_selector,
      subscription_type: subscription_type,
      admin_user: admin_user
    )
    subscription.save!
    subscription
  end
end
