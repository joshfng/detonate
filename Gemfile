# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.2'
gem 'rails', '~> 6.1.3'
gem 'redis', '~> 4.0'
gem 'redis-namespace'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

# gem 'prerender_chrome', path: '/Users/josh/code/joshfng/prerender_chrome'

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

gem 'rack-canonical-host'

gem 'pghero'
gem 'pg_query', '>= 0.9.0'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'foreman'
  gem 'letter_opener'
  gem 'listen', '~> 3.5'
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
