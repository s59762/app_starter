Sidekiq.configure_server do |config|
  config.redis = { url: "#{ENV['redis_url']}/#{ENV['redis_sidekiq_db_no']}", namespace: ENV['app_name'], driver: :hiredis }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "#{ENV['redis_url']}/#{ENV['redis_sidekiq_db_no']}", namespace: ENV['app_name'], driver: :hiredis }
end
