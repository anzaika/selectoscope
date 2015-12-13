Rack::Utils.multipart_part_limit = 0

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
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger.const_get('DEBUG')
  config.log_level    = :debug
  config.active_record.raise_in_transactional_callbacks = true
end
