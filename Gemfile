# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.2', '>= 6.1.2.1'
gem 'redis', '~> 4.0'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Authentication
gem 'devise'

# Encryption
gem 'blind_index'
gem 'lockbox'

# Background workers
gem 'sidekiq'
gem 'sidekiq-cron'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'brakeman'
  gem 'byebug'
  gem 'bundler-audit'
  gem 'rspec-rails'
end

group :development do
  gem 'foreman'
  gem 'letter_opener'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'simplecov', require: false
  gem 'timecop'
end
