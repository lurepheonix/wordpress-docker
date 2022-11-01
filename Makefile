include .env
DCF = docker-compose.yml

.PHONY: up
up: 
	@docker compose up -d web php db redis

.PHONY: down
down: 
	@docker compose down

.PHONY: node-enter
node-enter:
	@docker compose --file=$(DCF) run --rm node /bin/bash

.PHONY: npm-i
npm-i:
	@docker compose --file=$(DCF) run --rm node /bin/sh -c "npm i --save-dev"

.PHONY: npm-build
npm-build:
	@docker compose --file=$(DCF) run --rm node /bin/sh -c "npm run build"

.PHONY: npm-watch
npm-watch:
	@docker compose --file=$(DCF) run --rm node /bin/sh -c "npm run watch"

# some sane defaults, edit for your project
.PHONY: wp-postinstall
wp-postinstall:

.PHONY: restore-db
restore-db:
	@docker compose --file=$(DCF) exec db /bin/sh -c "/usr/bin/mysql -u root --password=$(MYSQL_ROOT_PASSWORD) -e 'DROP DATABASE $(MYSQL_DATABASE);'"
	@docker compose --file=$(DCF) exec db /bin/sh -c "/usr/bin/mysql -u root --password=$(MYSQL_ROOT_PASSWORD) -e 'CREATE DATABASE $(MYSQL_DATABASE) charset utf8 collate utf8_general_ci;'"
	@cat dump.sql | pv | docker compose --file=$(DCF) exec -T db /usr/bin/mysql -u root --password=$(MYSQL_ROOT_PASSWORD) $(MYSQL_DATABASE)
