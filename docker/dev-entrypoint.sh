#!/bin/sh

set -e

echo "Environment: $RAILS_ENV"

# Check if we need to install new gems
bundle check || bundle install --jobs 20 --retry 5

yarn install

# Remove pre-existing puma/passenger server.pid
rm -f "${APP_PATH}"/tmp/pids/server.pid || true

bundle exec rails db:prepare

# Then run any passed command
bundle exec "${@}"
