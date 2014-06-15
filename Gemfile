source 'https://rubygems.org'

ruby "2.1.1"

gem 'rails', '4.1.1'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
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
gem 'slim-rails'
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
