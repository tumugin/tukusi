FactoryBot.define do
  factory :notify_target do
    name { 'Test Target' }
    admin_user

    trait :notify_type_slack do
      notify_type { NotifyTarget::NOTIFY_TYPE_SLACK }
      slack_notify_target
    end
  end
end
