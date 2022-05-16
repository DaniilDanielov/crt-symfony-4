# crt-symfony-4
Запуск приложения 

1.Переименовать файл "symfony/.env.dist" в ".env" \

2. В корневой папке проекта ввести команды: 


docker-compose up -d \
docker-compose exec app composer install \
docker-compose exec app bin/console doctrine:migrations:migrate \
docker-compose exec app bin/console lexik:jwt:generate-keypair \
или \
ввести команду make start-project


3.Для генерации ключей в localhost/api создан endpoint /authentication_token с данными администратора по умолчанию \
4.Данные для входа Администратора Login:admin Password:adminadmin \
5.Данные для входа Юзера Login:user Password:useruser \
6.Для проверки ключей https://jwt.io/ \


