source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

gem 'rails', '~> 5.2.4'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 5.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rest-client'
gem 'recursive-open-struct'
gem "activerecord-import"
gem 'active_model_serializers', '~> 0.10.0'
gem 'awesome_print'
group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
