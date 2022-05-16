# crt-symfony-4
Запуск приложения 

В корневой папке проекта ввести команды: 


1.Переименовать файл "symfony/.env.dist" в ".env" \
2.docker-compose up -d \
3.docker-compose exec app composer install \
4.docker-compose exec app bin/console doctrine:migrations:migrate \
5 docker-compose exec app bin/console lexik:jwt:generate-keypair \
6.Для генерации ключей в localhost/api создан endpoint /authentication_token с данными администратора по умолчанию \
7.Данные для входа Администратора Login:admin Password:adminadmin \
8.Данные для входа Юзера Login:user Password:useruser \
9.Для проверки ключей https://jwt.io/ \


