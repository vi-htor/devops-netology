## Задание 1

Что ж, деплойменты хранятся в директории [app](src/app), сетевые политики в [net-policy](src/net-policy).

Проинициализировав поды получаем следующее:
```bash
vi:src/ (main✗) $ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
frontend-75dccb9c87-sfxbv   1/1     Running   0          9m45s
backend-5c564cdb79-zhqjk    1/1     Running   0          9m41s
cache-6dbb79c47c-c6q4g      1/1     Running   0          9m38s
vi:src/ (main✗) $ kubectl get svc
NAME       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
frontend   ClusterIP   10.152.183.233   <none>        80/TCP    9m49s
backend    ClusterIP   10.152.183.64    <none>        80/TCP    9m45s
cache      ClusterIP   10.152.183.61    <none>        80/TCP    9m42s
```

Проверяем, что на текущий момент трафик ходит свободно:
```bash
vi:src/ (main✗) $ kubectl exec frontend-75dccb9c87-sfxbv -- curl backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   140  100   140    0     0    467      0 --:--:-- --:--:-- --:--:--  1414
WBITT Network MultiTool (with NGINX) - backend-5c564cdb79-zhqjk - 10.1.205.30 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
vi:src/ (main✗) $ kubectl exec frontend-75dccb9c87-sfxbv -- curl cache
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   138  100   138    0     0    461      0 --:--:-- --:--:-- --:--:--  1380
WBITT Network MultiTool (with NGINX) - cache-6dbb79c47c-c6q4g - 10.1.205.31 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
```

Запрещаем весь трафик [политикой по умолчанию](src/net-policy/0-default.yaml) и проверяем:
```bash
vi:src/ (main✗) $ kubectl apply -f net-policy/0-default.yaml
networkpolicy.networking.k8s.io/default-deny-ingress created
vi:src/ (main✗) $ kubectl exec frontend-75dccb9c87-sfxbv -- curl backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:--  0:00:08 --:--:--     0
```

Разрешаем трафик по схеме из задания и проверяем:
```bash
vi:src/ (main✗) $ kubectl apply -f net-policy/2-backend-policy.yaml
networkpolicy.networking.k8s.io/backend created
vi:src/ (main✗) $ kubectl apply -f net-policy/3-cache-policy.yaml
networkpolicy.networking.k8s.io/cache created
# net on front
kubectl exec frontend-75dccb9c87-sfxbv -- curl backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   140  100   140    0     0    467      0 --:--:-- --:--:-- --:--:--   700
WBITT Network MultiTool (with NGINX) - backend-5c564cdb79-zhqjk - 10.1.205.30 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
vi:src/ (main✗) $ kubectl exec frontend-75dccb9c87-sfxbv -- curl cache
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:--  0:00:04 --:--:--     0
# net on back
vi:src/ (main✗) $ kubectl exec backend-5c564cdb79-zhqjk -- curl frontend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0^C
vi:src/ (main✗) $ kubectl exec backend-5c564cdb79-zhqjk -- curl cache
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   138  100   138    0     0    462      0 --:--:-- --:--:-- --:--:--  134k
WBITT Network MultiTool (with NGINX) - cache-6dbb79c47c-c6q4g - 10.1.205.31 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
# net on cache
vi:src/ (main✗) $ kubectl exec cache-6dbb79c47c-c6q4g -- curl frontend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0^C
vi:src/ (main✗) $ kubectl exec cache-6dbb79c47c-c6q4g -- curl backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0^C
```

---
ps. файл [1-frontend-policy.yaml](src/net-policy/1-frontend-policy.yaml) создан для теста и не требуется, так как все прочие соединения блокируются политикой по умолчанию.