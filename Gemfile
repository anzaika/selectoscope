source "https://rubygems.org"

#------> Core
gem "rails", "~> 4.2.5"
gem "activeadmin", github: "activeadmin"
gem "cancancan"
gem "mysql2", "~> 0.3.20"
gem "unicorn"
gem "unicorn-rails"
gem "jbuilder"
gem "uglifier"
gem "devise"
gem "sidekiq"
gem "sidekiq-failures"
gem "sinatra", require: nil
gem "sidekiq-limit_fetch"
gem "sidekiq-status"
gem "sidekiq-statistic"
gem "draper"
gem "transaction_retry"
gem "responsive_active_admin"
gem "paper_trail"
gem "active_type", github: "makandra/active_type"

gem "rollbar"
gem "oj"
gem 'oj_mimic_json'

#------> Interface
gem "jquery-rails"
gem "coffee-rails"
gem "haml-rails"
gem "sass-rails"
gem "turbolinks"
gem "therubyracer", platforms: :ruby

#------> Bio
gem "newick-ruby", github: "jhbadger/Newick-ruby"
# gem "rserve-client"
gem "bio", github: "anzaika/bioruby", branch: "master"

#------> Helpers
gem "parallel"
gem "ruby-progressbar"
gem "paperclip"

group :development, :test do
  gem "guard-rspec", require: false
  gem "spring"
  gem "pry-rails"
  gem "pry-rescue"
  gem "better_errors"
  gem "binding_of_caller"
  gem "quiet_assets"
  gem "rb-inotify", require: false
  gem "spring-commands-rspec"
  gem "rubocop"
end

group :test do
  gem "webmock"
  gem "fabrication", require: false
  gem "rspec-rails", "~> 3.4.2"
  gem "database_cleaner"
  gem "shoulda-matchers", "~> 3.1"
end
