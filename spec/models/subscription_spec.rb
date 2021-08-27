require 'rails_helper'

RSpec.describe 'Subscription', type: :model do
  describe 'scope :enabled?' do
    it 'when it has no enabled subscription' do
      create(:subscription, :disabled)
      expect(Subscription.enabled?.count).to be 0
    end

    it 'when it has enabled subscription' do
      create(:subscription)
      expect(Subscription.enabled?.count).to be 1
    end
  end

  describe 'scope needs_crawl?' do
    it 'when it does not have expired crawl_log' do
      subscription = create(:subscription)
      crawl_log = create(:crawl_log, subscription: subscription)
      travel_to(crawl_log.started_at)
      expect(Subscription.needs_crawl?.count).to be 0
    end

    it 'when it have expired crawl_log' do
      subscription = create(:subscription)
      crawl_log = create(:crawl_log, subscription: subscription)
      travel_to(crawl_log.started_at + subscription.check_interval_seconds.seconds)
      expect(Subscription.needs_crawl?.count).to be 1
    end
  end
end
