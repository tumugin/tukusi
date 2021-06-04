class Subscription < ApplicationRecord
  belongs_to :admin_user
  has_many :notify_targets, through: :notify_targets_of_subscriptions
end
