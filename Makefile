RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

add-migration:
	docker compose run --rm app bin/rails g migration $(RUN_ARGS)

add-model:
	docker compose run --rm app bin/rails g model $(RUN_ARGS)

db-create:
	docker compose run --rm app bin/rails db:create

db-migrate:
	docker compose run --rm app bin/rails db:migrate

db-seed:
	docker compose run --rm app bin/rails db:seed

db-rollback:
	docker compose run --rm app bin/rails db:rollback

lint-ruby:
	docker compose run --rm app bundle exec rubocop -a

lint-security:
	docker compose run --rm app -- bin/bundler-audit --update && bin/brakeman -q --no-pager

ci:
	docker compose run --rm test bundle exec rspec

redis:
	docker compose exec redis redis-cli

psql:
	docker compose exec db psql -U postgres

bash:
	docker compose run --rm app bash

run-console:
	docker compose run --rm app bin/rails console

run-generate:
	docker compose run --rm app bin/rails generate $(RUN_ARGS)

run-rails:
	docker compose up app

run-sidekiq:
	docker compose up worker

run:
	docker compose up

build:
	docker compose build --no-cache

down:
	docker compose down --remove-orphans

kill:
	docker compose kill

c: run-console

g: run-generate

s: run
