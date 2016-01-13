Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://hpc02:6379/12' }
end

Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://hpc02:6379/12' }
end
