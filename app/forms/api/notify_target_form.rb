class Api::NotifyTargetForm
  include ActiveModel::Model

  attr_accessor :id, :name, :notify_type, :target_detail, :admin_user

  validates :id, presence: true, numericality: { only_integer: true }, allow_nil: true
  validates :name, presence: true, length: { minimum: 1 }
  validates :notify_type, presence: true, inclusion: { in: NotifyTarget::NOTIFY_TYPES }
  validates :target_detail, presence: true
  validate :target_detail
  validates :admin_user, presence: true, if: :needs_validate_admin_user

  def needs_validate_admin_user
    id.nil?
  end

  def get_notify_target
    if id.nil?
      NotifyTarget.new(admin_user: admin_user)
    else
      NotifyTarget.find(id)
    end
  end

  def save!
    validate!
    notify_target = get_notify_target
    ActiveRecord::Base.transaction do
      notify_target.assign_attributes({ name: name, notify_type: notify_type })
      notify_target.save!
      target_detail.save!(notify_target)
    end
    notify_target
  end
end
