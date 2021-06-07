class Api::CreateSlackNotifyTargetForm
  include ActiveModel::Model

  attr_accessor :webhook_url

  validates :webhook_url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/

  def save!(notify_target)
    validate!
    SlackNotifyTarget.create!(webhook_url: webhook_url, notify_target: notify_target)
  end
end
