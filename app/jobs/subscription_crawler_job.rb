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

    begin
      case subscription.subscription_type
      when Subscription::SUBSCRIPTION_TYPE_NOKOGIRI then
        captured_data = Crawler::NokogiriCrawler.new(
          url: subscription.target_url,
          selector: subscription.target_selector,
          timeout_seconds: subscription.timeout_seconds
        ).perform
      else
        raise '未実装のクローラーです'
      end
    rescue => ex
      Jobs::CrawlLogForm.new(
        id: crawl_log_id,
        duration: (Time.current - started_at).seconds,
        result: CrawlLog::RESULT_FAILED,
        started_at: started_at,
        ended_at: Time.current,
        captured_data: nil,
      ).save!.id
      raise ex
    end


    Jobs::CrawlLogForm.new(
      id: crawl_log_id,
      duration: (Time.current - started_at).seconds,
      result: CrawlLog::RESULT_SUCCESS,
      started_at: started_at,
      ended_at: Time.current,
      captured_data: captured_data,
    ).save!.id
  end
end
