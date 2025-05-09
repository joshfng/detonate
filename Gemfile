# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 8.0'

gem 'jbuilder'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'turbolinks'
gem 'webpacker'

gem 'rexml'

# Authentication
gem 'devise'

# Encryption
gem 'blind_index'
gem 'lockbox'

# Background worker stuff
gem 'redis'
gem 'redis-namespace'
gem 'sidekiq', '~> 8.0'
gem 'sidekiq-cron'

gem 'rack-canonical-host'

gem 'pghero'
gem 'pg_query'

gem 'bootsnap', require: false

group :development, :test do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'foreman'
  gem 'letter_opener'
  gem 'listen'
  gem 'rack-mini-profiler'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  # gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'factory_bot_rails'
  gem 'simplecov', require: false
  gem 'timecop'
end
