SIDEKIQ_CRON_JOBS = {
  subscription_crawler_poller: {
    # 開発時に有効になっていると不便なので無効化しておく
    status: Rails.env.production? ? 'enabled' : 'disabled',
    cron: '* * * * *',
    class: 'SubscriptionCrawlerPollerJob',
    description: 'Run crawler job cron.'
  }
}.freeze

Sidekiq::Cron::Job.load_from_hash(SIDEKIQ_CRON_JOBS) if Sidekiq.server?
