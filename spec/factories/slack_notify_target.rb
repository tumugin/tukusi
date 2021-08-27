FactoryBot.define do
  factory :slack_notify_target do
    webhook_url { 'https://example.com/slack_test' }
  end
end
