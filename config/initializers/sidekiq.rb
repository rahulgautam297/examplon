Sidekiq.configure_server do |config|
  config.redis = { url: REDISCLOUD_URL, size: 27 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: REDISCLOUD_URL, size: 3 }
end

#remove url key to run server locally.