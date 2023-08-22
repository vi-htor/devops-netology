## Решение

1-ая ошибка - отсутствие namespaces - создаём их:
```bash
vi:src/ (main✗) $ kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "web" not found
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "data" not found
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "data" not found
vi:src/ (main✗) $ kubectl create namespace web
namespace/web created
vi:src/ (main✗) $ kubectl create namespace data
namespace/data created
```
2-ая ошибка (сразу забегу вперёд) - в моём случае это образ, так как он обновлялся в последний раз лет 8 назад - arm архитектуры нету :( - в рамках теста меняю на `curlimages/curl`.

Ну и сама суть проблемы - отсутствие коннекта к db:
```bash
vi:~/ $ kubectl logs web-consumer-84f84749f9-6p882 -n web
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (6) Could not resolve host: auth-db
```
Заключается она в том, что сервис находится в другом namespace, а короткая ссылка только по названию доступла лишь внутри одного пространсва имен - фиксим имя в комманде `while true; do curl auth-db.data; sleep 5; done` и проверяем:
```bash
vi:~/ $ kubectl logs web-consumer-67955df99f-58x5r -n web
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
<...>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>
<...>
```

Исправленный deployment лежит [здесь](src/task.yaml)