source 'https://rubygems.org'

ruby "2.1.1"

gem 'rails', '4.1.1'
gem 'sass-rails'
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
gem 'gemoji', github: 'github/gemoji'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'pry-rails'
  gem 'spring'
  gem "spring-commands-rspec"
  gem 'sqlite3'
  gem "letter_opener"
  gem "faker"
  gem "meta_request"
  gem "better_errors"
  gem "binding_of_caller"
  gem "quiet_assets"
  gem "codeclimate-test-reporter", require: false
  gem 'fabrication'
  gem "rspec-rails"
  gem 'brakeman'
end
