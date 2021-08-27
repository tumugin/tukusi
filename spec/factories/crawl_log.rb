FactoryBot.define do
  factory :crawl_log do
    duration { 1.1 }
    result { CrawlLog::RESULT_SUCCESS }
    started_at { Time.zone.parse('2021-06-27 10:00:00') }
    ended_at { Time.zone.parse('2021-06-27 10:00:10') }
    captured_data { '汐入あすかはかわいい' }

    trait :failed do
      result { CrawlLog::RESULT_FAILED }
    end

    trait :notify_failed do
      result { CrawlLog::RESULT_NOTIFY_FAILED }
    end

    trait :running do
      result { CrawlLog::RESULT_RUNNING }
      ended_at { nil }
    end
  end
end
