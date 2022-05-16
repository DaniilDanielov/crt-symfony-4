start-project:
	docker-compose up --build -d
	docker-compose exec app composer install
	docker-compose exec app bin/console doctrine:migrations:migrate
	docker-compose exec app bin/console lexik:jwt:generate-keypair
