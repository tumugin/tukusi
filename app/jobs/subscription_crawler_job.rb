class SubscriptionCrawlerJob < ApplicationJob
  # @param subscription_id Integer
  def perform(subscription_id)
    # クロール処理を呼び出す
    started_at = Time.current
    subscription = Subscription.find(subscription_id)
    crawl_log_id = Jobs::CrawlLogForm.new(
      result: CrawlLog::RESULT_RUNNING,
      started_at: started_at,
      subscription: subscription
    ).save!.id

    captured_data = nil

    case subscription.subscription_type
    when Subscription::SUBSCRIPTION_TYPE_NOKOGIRI then
      captured_data = Crawler::NokogiriCrawler.new(
        url: subscription.target_url,
        selector: subscription.target_selector,
        timeout_seconds: subscription.timeout_seconds
      ).perform
    end

    Jobs::CrawlLogForm.new(
      id: crawl_log_id,
      duration: 0,
      result: CrawlLog::RESULT_SUCCESS,
      started_at: started_at,
      ended_at: Time.current,
      captured_data: captured_data,
      subscription: subscription
    ).save!.id
  end
end
