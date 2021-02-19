#!/bin/sh

set -e

echo "Environment: $RAILS_ENV"
echo "DATABASE_URL: $DATABASE_URL"

# install missing gems
bundle check || bundle install --jobs 20 --retry 5

# Remove pre-existing puma/passenger server.pid
rm -f $APP_PATH/tmp/pids/server.pid || true

# run passed commands
bundle exec ${@}
