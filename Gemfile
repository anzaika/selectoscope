source "https://rubygems.org"

#------> Core
gem "rails"
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

gem "rollbar"
gem "oj"

#------> Interface
gem "jquery-rails"
gem "coffee-rails"
gem "haml-rails"
gem "sass-rails"
gem "turbolinks"
gem "therubyracer", platforms: :ruby
gem "bootstrap-sass"

#------> Bio
gem "newick-ruby", github: "jhbadger/Newick-ruby"
gem "rserve-client"
gem "bio", github: "anzaika/bioruby", branch: "master"

#------> Helpers
gem "parallel"
gem "ruby-progressbar"
gem "paperclip"

group :development do
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-bundler"
  gem "capistrano-rbenv"
  gem "better_errors"
  gem "binding_of_caller"
  gem "html2haml"
  gem "quiet_assets"
  gem "rails_layout"
  gem "rb-fchange", require: false
  gem "rb-fsevent", require: false
  gem "rb-inotify", require: false
  gem "rubocop"
end

group :test do
  gem "fabrication", require: false
  gem "faker"
  gem "pry-rails"
  gem "pry-rescue"
  gem "rspec-rails"
  gem "shoulda"
  gem "guard-rails"
  gem "guard-rspec", require: false
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
end
