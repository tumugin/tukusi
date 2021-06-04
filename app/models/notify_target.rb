class NotifyTarget < ApplicationRecord
  belongs_to :admin_user
  has_many :subscriptions, through: :notify_targets_of_subscriptions

  NOTIFY_TYPE_SLACK = 'slack'
  NOTIFY_TYPES = [NOTIFY_TYPE_SLACK]

  def target_details
    case notify_type
    when NOTIFY_TYPE_SLACK then
      return SlackNotifyTarget.find(target_id)
    else
      return nil
    end
  end
end
