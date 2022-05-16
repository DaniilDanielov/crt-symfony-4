down:
	docker-compose down

restart:
	docker-compose down
	docker-compose up --build -d

pull-build:
	docker-compose pull
	docker-compose up --build -d
	docker-compose exec app composer install

clear-d:
	docker-compose exec app bin/console doctrine:database:drop --force
	docker-compose exec app bin/console doctrine:database:create
	docker-compose exec app bin/console doctrine:migrations:migrate -n
	docker-compose exec app bin/console doctrine:fixtures:load -n

cache:
	docker-compose exec app bin/console cache:clear --no-debug
	docker-compose exec app bin/console redis:flushdb --client=cache -n

token-admin:
	docker-compose exec app bin/console lexik:jwt:generate-token --user-class App\\Entity\\User nem@webcrt.ru

reboot:
	docker-compose down
	docker-compose up -d

check:
	docker-compose exec app vendor/bin/php-cs-fixer fix
	docker-compose exec app vendor/bin/psalm --no-cache
	docker-compose exec app bin/phpunit

recreate-db:
	docker-compose exec app bin/console doctrine:database:drop --force
	docker-compose exec app bin/console doctrine:database:create
	docker-compose exec app bin/console doctrine:migrations:migrate
	docker-compose exec app bin/console doctrine:fixtures:load
