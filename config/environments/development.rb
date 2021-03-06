Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.raise_runtime_errors = true

  # config.action_view.logger = nil
  # config.logger.level = Logger.const_get("DEBUG")
  config.log_level = :debug
  config.active_record.raise_in_transactional_callbacks = true

  config.assets.digest = false
  config.assets.compress = false
  config.enable_anon_caching = false

  BetterErrors::Middleware.allow_ip!("172.20.0.1")
  config.load_mini_profiler = true
  require "rbtrace"
end
