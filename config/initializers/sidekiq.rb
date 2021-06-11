Sidekiq.configure_server do |config|
  config.redis = { url: ENV['SIDEKIQ_REDIS_SERVER_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['SIDEKIQ_REDIS_CLIENT_URL'] }
end
