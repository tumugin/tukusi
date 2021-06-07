class Api::CreateNotifyTargetForm
  include ActiveModel::Model

  attr_accessor :name, :notify_type, :target_detail, :admin_user_id

  validates :name, presence: true, length: { minimum: 1 }
  validates :notify_type, presence: true, inclusion: { in: NotifyTarget::NOTIFY_TYPES }
  validates :target_detail, presence: true
  validate :target_detail
  validates :admin_user_id, presence: true

  def save!
    validate!
    ActiveRecord::Base.transaction do
      notify_target = NotifyTarget.new(name: name, notify_type: notify_type, admin_user_id: admin_user_id)
      notify_target.save!
      target_detail.save!(notify_target)
      return notify_target
    end
  end
end
