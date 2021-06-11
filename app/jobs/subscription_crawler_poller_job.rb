class SubscriptionCrawlerPollerJob < ApplicationJob
  def perform(*)
    Subscription.enabled?.needs_crawl?.find_each do |subscription|
      # クロールするジョブをキューに積む
      SubscriptionCrawlerJob.perform_now(subscription.id)
    end
  end
end
