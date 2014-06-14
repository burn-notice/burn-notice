source 'https://rubygems.org'

ruby "2.1.1"

gem 'rails', '4.1.1'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sinatra', require: false
gem 'sidekiq', require: 'sidekiq/web'
gem 'sidekiq-unique-jobs'
gem 'clockwork'
gem 'premailer-rails'
gem 'nokogiri'
gem 'newrelic_rpm'
gem "omniauth"
gem "omniauth-twitter"
gem "omniauth-github"
gem "omniauth-facebook"
gem "decent_exposure"
gem 'activeadmin', github: 'gregbell/active_admin'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'spring'
  gem "spring-commands-rspec"
  gem 'sqlite3'
  gem "letter_opener"
  gem "faker"
  gem "pry-rails"
  gem "rspec-rails"
  gem 'fabrication'
  gem "meta_request"
  gem "better_errors"
  gem "binding_of_caller"
  gem "quiet_assets"
  gem "codeclimate-test-reporter", require: false
end

group :test do
  gem 'brakeman'
end
