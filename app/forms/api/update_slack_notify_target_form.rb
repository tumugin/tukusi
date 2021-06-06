class Api::UpdateSlackNotifyTargetForm
  include ActiveModel::Model

  attr_accessor :webhook_url

  validates :webhook_url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
end
