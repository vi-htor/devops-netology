## Task 1

Deployments и services опять в одном [манифесте](src/1-1-multi-deployment.yaml)

Не совсем понял, как именно можно обеспечить одним сервисом взаимосвязь между двумя деплойментами, поэтому создал по сервису на каждый.

Выводы команд:
```bash
vi:src/ $ kubectl get deployments
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
task-1-back    2/2     2            2           3m
task-1-front   3/3     3            3           3m
vi:src/ $ kubectl get services
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
back-svc     ClusterIP   10.97.251.52     <none>        8080/TCP   3m11s
front-svc    ClusterIP   10.110.190.114   <none>        80/TCP     3m11s
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP    29m
vi:src/ $ kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
task-1-back-7c8f697c84-dqbsq    1/1     Running   0          3m28s
task-1-back-7c8f697c84-slpfh    1/1     Running   0          3m28s
task-1-front-5455fbcb4c-jdc8h   1/1     Running   0          3m28s
task-1-front-5455fbcb4c-p8wqn   1/1     Running   0          3m28s
task-1-front-5455fbcb4c-zggtp   1/1     Running   0          3m28s
vi:src/ $ kubectl exec -it task-1-back-7c8f697c84-slpfh /bin/bash
bash-5.1# curl front-svc:80
<...>
<title>Welcome to nginx!</title>
<...>
```

## Task 2

Конфигурация [ingress](src/2-1-ingress.yaml)

Выводы команд:
```bash
# сначала установим ingress-контроллер
vi:src/ $ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.7.0/deploy/static/provider/cloud/deploy.yaml
# после чего уже добавим свой ingress
vi:src/ $ kubectl apply -f 2-1-ingress.yaml
ingress.networking.k8s.io/task-2-ingress created
vi:src/ $ curl localhost
<...>
<title>Welcome to nginx!</title>
<...>
vi:src/ $ curl localhost/api
WBITT Network MultiTool (with NGINX) - task-1-back-7c8f697c84-dqbsq - 10.1.0.250 - HTTP: 8080 , HTTPS: 443 . (Formerly praqma/network-multitool)
```