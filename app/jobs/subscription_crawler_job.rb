class SubscriptionCrawlerJob < ApplicationJob
  sidekiq_options retry: false

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
    begin
      captured_data = subscription.fetch_crawled_result
      Jobs::CrawlLogForm.new(
        id: crawl_log_id,
        duration: (Time.current - started_at).seconds,
        result: CrawlLog::RESULT_SUCCESS,
        started_at: started_at,
        ended_at: Time.current,
        captured_data: captured_data
      ).save!
    rescue StandardError => e
      Jobs::CrawlLogForm.new(
        id: crawl_log_id,
        duration: (Time.current - started_at).seconds,
        result: CrawlLog::RESULT_FAILED,
        started_at: started_at,
        ended_at: Time.current,
        captured_data: captured_data
      ).save!
      subscription.notify_failed!
      raise e
    end

    begin
      # 通知処理
      subscription.notify! if subscription.update?
    rescue StandardError => e
      Jobs::CrawlLogForm.new(
        id: crawl_log_id,
        duration: (Time.current - started_at).seconds,
        result: CrawlLog::RESULT_NOTIFY_FAILED,
        started_at: started_at,
        ended_at: Time.current,
        captured_data: captured_data
      ).save!
      raise e
    end
  end
end
