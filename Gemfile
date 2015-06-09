source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'rails', '4.2.1'
gem 'responders'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'compass-rails'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'sucker_punch'
gem 'premailer-rails'
gem 'nokogiri'
gem 'newrelic_rpm'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'decent_exposure'
gem 'slim-rails'
gem 'kaminari'
gem 'typus', github: 'burn-notice/typus', branch: 'fix_some_stuffs'
# gem 'typus', github: 'typus/typus', branch: 'master'
# gem 'typus', path: '/Users/peterschroder/Documents/rails/typus'
gem 'gemoji'
gem 'rack-cache'
gem 'pg'
gem 'redcarpet'
gem 'exception_notification'

group :production do
  gem 'rails_12factor'
  gem 'heroku-deflater'
end

group :development do
  gem 'letter_opener'
  gem 'partially_useful'
  gem 'meta_request'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'byebug'
  gem 'fabrication'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'faker'
  gem 'brakeman', require: false
  gem 'codeclimate-test-reporter', require: false
end
