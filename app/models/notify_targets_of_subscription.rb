class NotifyTargetsOfSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :notify_target
end
