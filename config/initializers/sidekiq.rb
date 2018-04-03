Sidekiq.configure_server do |config|
  config.redis = { url: ENV['redis_url'], namespace: ENV['app_name'], driver: :hiredis }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['redis_url'], namespace: ENV['app_name'], driver: :hiredis }
end
