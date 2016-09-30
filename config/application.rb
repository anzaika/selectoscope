require File.expand_path("../boot", __FILE__)

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Make it possible to upload almost infine number of files
Rack::Utils.multipart_part_limit = 0

module Burkh
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures:         true,
                       view_specs:       false,
                       helper_specs:     false,
                       routing_specs:    false,
                       controller_specs: false,
                       request_specs:    false
    end

    config.active_job.queue_adapter = :sidekiq
    config.autoload_paths << Rails.root.join('lib')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = ENV["TIME_ZONE"] || "Central Time (US & Canada)"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
  end
end
