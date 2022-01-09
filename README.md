# crt-symfony-4
Запуск приложения 

В корневой папке проекта ввести команды: 

1.docker-compose up -d \
2.docker-compose exec app composer install \
3.docker-compose exec app bin/console doctrine:migrations:migrate \
4 docker-compose exec app bin/console lexik:jwt:generate-keypair \
5.Дамп базы данных находится в папке postgres/dump \
6.Для генерации ключей в localhost/api создан endpoint /authentication_token с данными администратора по умолчанию \
7.Данные для входа Администратора Login:admin Password:adminadmin \
8.Данные для входа Юзера Login:user Password:useruser \
9.Для проверки ключей https://jwt.io/ 

Комментарии по заданию № 5:\
Все "Эндпоинты" реализованы в соотвествии с заданием, в пункты с корзиной дополнительно добавил описание \
Для отправки списка пицц в текущую корзину - заменить string в "pizzasId":["string"] на Id пицц например:'1,2,3' \
PUT И DELETE в качестве Id принимают ID Пиццы, находящейся в корзине
Тестирование реализовано частично - в MainControllerTest добавлен тест адреса /api/pizzas \
Тестирование других "Эндпоинтов" реализовано однако сами тесты не запускаются, т.к. команда ./vendor/bin/phpunit не запускает TestApi 
