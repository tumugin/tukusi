class Api::CreateNotifyTargetForm
  include ActiveModel::Model

  attr_accessor :name, :notify_type, :target_detail, :admin_user_id

  has_one :target_detail
  validates :name, presence: true, length: { minimum: 1 }
  validates :notify_type, presence: true, inclusion: { in: NotifyTarget::NOTIFY_TYPES }
  validates_associated :target_detail, presence: true
  validates :admin_user_id, presence: true

  def save!
    validate!
    ActiveRecord::Base.transaction do
      case notify_type
      when NotifyTarget::NOTIFY_TYPE_SLACK
        notify_target_detail = SlackNotifyTarget.new(webhook_url: target_detail.webhook_url)
        notify_target_detail.save!
      end
      notify_target = NotifyTarget.new(name: name, notify_type: notify_type, target_id: notify_target_detail.id, admin_user_id: admin_user_id)
      notify_target.save!
      notify_target_detail.notify_target = notify_target
      notify_target_detail.save!
      return notify_target
    end
  end
end
