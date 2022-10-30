include .env
DCF = docker-compose.yml

.PHONY: up
up: 
	@docker compose up -d web php db redis

.PHONY: down
down: 
	@docker compose down

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
	@docker compose --file=$(DCF) exec --user www-data php php -d xdebug.mode=off /usr/local/bin/wp plugin install advanced-custom-fields show-current-template wordpress-seo genesis-custom-blocks wp-extra-file-types
	@docker compose --file=$(DCF) exec --user www-data php php -d xdebug.mode=off /usr/local/bin/wp plugin activate advanced-custom-fields show-current-template wordpress-seo genesis-custom-blocks wp-extra-file-types
