class Api::UpdateSlackNotifyTargetForm
  include ActiveModel::Model

  attr_accessor :webhook_url

  validates :webhook_url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/

  def save!(notify_target)
    validate!
    slack_notify_target = notify_target.slack_notify_target || SlackNotifyTarget.new
    slack_notify_target
      .assign_attributes(
        {
          webhook_url: target_detail.webhook_url,
          notify_target: notify_target
        }
      )
    slack_notify_target.save!
    slack_notify_target
  end
end
