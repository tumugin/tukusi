FactoryBot.define do
  factory :subscription do
    name { 'スターダストプロモーション声優部オフィシャルブログ' }
    enabled { true }
    check_interval_seconds { 3600 }
    target_url { 'https://example.com/' }
    target_selector { 'div' }
    timeout_seconds { 3600 }
    subscription_type { Subscription::SUBSCRIPTION_TYPE_PLAIN }
    admin_user

    trait :disabled do
      enabled { false }
    end

    trait :subscription_type_nokogiri do
      subscription_type { Subscription::SUBSCRIPTION_TYPE_NOKOGIRI }
    end

    trait :subscription_type_plain do
      subscription_type { Subscription::SUBSCRIPTION_TYPE_PLAIN }
    end

    trait :subscription_type_json do
      subscription_type { Subscription::SUBSCRIPTION_TYPE_JSON }
    end
  end
end
