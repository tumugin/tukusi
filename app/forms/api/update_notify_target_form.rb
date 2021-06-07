class Api::UpdateNotifyTargetForm
  include ActiveModel::Model

  attr_accessor :id, :name, :notify_type, :target_detail

  validates :name, length: { minimum: 1 }
  validates :notify_type, inclusion: { in: NotifyTarget::NOTIFY_TYPES }
  validates :target_detail
  validate :target_detail

  def save!
    validate!
    notify_target = NotifyTarget.find(id)

    ActiveRecord::Base.transaction do
      notify_target.update!(
        name: name,
        notify_type: notify_type
      )
      target_detail.save!(notify_target)
    end

    notify_target
  end
end
