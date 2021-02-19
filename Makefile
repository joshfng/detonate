# https://stackoverflow.com/a/14061796/2237879
#
# This hack allows you to run make commands with any set of arguments.
#
# For example, these lines are the same:
#   > make g devise:install
#   > bundle exec rails generate devise:install
# And these:
#   > make add-migration add_deleted_at_to_users deleted_at:datetime
#   > bundle exec rails g migration add_deleted_at_to_users deleted_at:datetime
# And these:
#   > make add-model Order user:references record:references{polymorphic}
#   > bundle exec rails g model Order user:references record:references{polymorphic}
#
RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

add-migration:
	docker-compose run --rm detonate_app rails g migration $(RUN_ARGS)

add-model:
	docker-compose run --rm detonate_app rails g model $(RUN_ARGS)

db-create:
	docker-compose run --rm detonate_app rails db:create

db-migrate:
	docker-compose run --rm detonate_app rails db:migrate

db-rollback:
	docker-compose run --rm detonate_app rails db:rollback

lint-ruby:
	docker-compose run --rm detonate_app rubocop -a

lint-security:
	docker-compose run --rm detonate_app brakeman

ci:
	docker-compose run --rm detonate_test rspec

run-console:
	docker-compose run --rm detonate_app rails console

run-generate:
	docker-compose run --rm detonate_app rails generate $(RUN_ARGS)

run-rails:
	docker-compose up detonate_app

run-sidekiq:
	docker-compose up detonate_worker

run:
	docker-compose up

build:
	docker-compose build

down:
	docker-compose down

kill:
	docker-compose kill

c: run-console

g: run-generate

s: run
