Description
=========

Так как было необходимо тестировать полученный результат, я создал три роли: `clickhouse`, `vector`, `lighthouse`. Соответветственно все они основаны на [предыдущем задании](https://github.com/vi-htor/devops-netology/tree/main/third-module/08-ansible-03-yandex).

Детали
------------

Есть файл [requirements.yml](ansible/requirements.yml), в котором содержится информация о необходимых ролях, загрузить можно с помощью команды `ansible-galaxy install -r requirements.yml`.  
Основной [плейбук](ansible/playbooks/test.yml) максимально простой и, по факту, вызывает отдельную, необходимую роль на каждый из хостов. 
Ролей всего три ([clickhouse](https://github.com/vi-htor/clickhouse.git), [vector](https://github.com/vi-htor/vector.git), [lighthouse](https://github.com/vi-htor/lighthouse.git) - *все роли кликабельны*) и делают они по факту то же, что и отдельные плеи из предыдущего дз, а именно - устанавливают и запускают `clickhouse`, `vector` и `lighthouse` на трёх отдельных нодах.  
Файл inventory  у меня собирается автоматически, с помощью terraform, поэтому в текущем репозитории он отсутствует.

Переменные ролей
--------------

Clickhouse:
```yaml
clickhouse_version:  # Версия устанавлеваимых пакетов clickhouse
clickhouse_packages: # Пакеты clickhouse, которые будут установлены
```

Vector:
```yaml
vector_version: # Версия устанавлеваимых пакетов clickhouse
vector_config: # Конфиг вектора, который будет переведён в yaml
vector_url: # Source пакета для загрузки
vector_config_dir: # Директория конфига vector
```

Lighthouse:
```yaml
lighthouse_dir: # Рабочая директория lighthouse
lighthouse_url: # Source пакета для загрузки
lighthouse_nginx_user: # User от которого будет работать nginx
```

P.S.
--------------

Я не стал описывать роли в каждом из их репозиториев для упращения чтения, ибо так или иначе заливать их для публичного использования не собираюсь([роль](https://github.com/AlexeySetevoi/ansible-clickhouse.git) для clickhouse в том же примере от AlexeySetevoi гораздо глубже, продуманнее и интереснее), так что в репозиториях с ролями оставлены дефолтные readme.