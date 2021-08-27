FactoryBot.define do
  factory :admin_user do
    name { '汐入あすか' }
    email { 'asuka@example.com' }
    password { 'test_password' }
    user_level { AdminUser::USER_LEVEL_ADMINISTRATOR }

    trait :administrator do
      user_level { AdminUser::USER_LEVEL_ADMINISTRATOR }
    end

    trait :supervisor do
      user_level { AdminUser::USER_LEVEL_SUPERVISOR }
    end

    before(:create, &:skip_confirmation!)
  end
end
