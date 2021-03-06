source "https://rubygems.org"

#------> Core
gem "rails", "~> 4.2"
gem "unicorn"
gem "activeadmin", github: "activeadmin"
gem "cancancan", "~> 1.13"
gem "mysql2"
gem "jbuilder", "~> 2.4"
gem "uglifier", "~> 2.7"
gem "devise", "~> 3.5"
gem "sidekiq", "~> 4.1"
gem "sidekiq-failures", "~> 0.4"
gem "sinatra", require: nil
gem "sidekiq-status"
gem "sidekiq-statistic"
gem "transaction_retry"
gem "responsive_active_admin"
gem "paper_trail", "~> 4.1"
gem "active_type"

gem "rollbar"
gem "oj"
gem "oj_mimic_json"

#------> Interface
gem "jquery-rails", "~> 4.1"
gem "coffee-rails"
gem "haml-rails"
gem "sass-rails"
gem "bootstrap-sass"
gem "therubyracer", platforms: :ruby

#------> Bio
gem "newick-ruby", github: "jhbadger/Newick-ruby"
gem "bio", github: "anzaika/bioruby", branch: "master"

#------> Statistics
gem "rinruby"

#------> Helpers
gem "paperclip", "~> 4.3"
gem "annotate"
gem "rerun"
gem "table_print"

group :development, :test do
  gem "guard-rspec", require: false
  gem "pry-rails"
  gem "pry-rescue"
  gem "better_errors"
  gem "binding_of_caller"
  gem "quiet_assets"
  gem "rb-inotify", require: false
  gem "spring-commands-rspec"
end

group :test do
  gem "faker"
  gem "fabrication", require: false
  gem "rspec-rails", "~> 3.4"
  gem "database_cleaner"
  gem "shoulda-matchers", "~> 3.1"
  gem "rake", require: false
  gem "parallel_tests"
  gem "capybara"
end

gem "rbtrace", require: false, platform: :mri
gem "flamegraph", require: false
gem "rack-mini-profiler", require: false
gem "stackprof", require: false, platform: %i(mri_21 mri_22 mri_23)
gem "memory_profiler", require: false, platform: %i(mri_21 mri_22 mri_23)
