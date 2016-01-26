if Rails.env.production?

  Sidekiq.configure_server do |config|
    config.redis = { url: "redis://#{ENV['REDIS_HOST']}:6379/12" }
    config.server_middleware do |chain|
      chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes
    end
    config.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes
    end
  end
  Sidekiq.configure_client do |config|
    config.redis = { url: "redis://#{ENV['REDIS_HOST']}:6379/12" }
    config.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes
    end
  end

elsif Rails.env.development?

  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://redis:6379/12' }
    config.server_middleware do |chain|
      chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes
    end
    config.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes
    end
  end
  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://redis:6379/12' }
    config.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes
    end
  end

end
