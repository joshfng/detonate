#!/bin/sh

set -e

echo "Environment: $RAILS_ENV"
echo "DATABASE_URL: $DATABASE_URL"

# Check if we need to install new gems
bundle check || bundle install --jobs 20 --retry 5

# Then run any passed command
bundle exec ${@}
