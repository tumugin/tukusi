class NotifyTarget < ApplicationRecord
  belongs_to :admin_user
  has_many :subscriptions, through: :notify_targets_of_subscriptions
end
