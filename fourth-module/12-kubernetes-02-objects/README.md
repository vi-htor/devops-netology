## Ремарка

На моей тестовой машинке отказался адекватно заводиться образ из задания `gcr.io/kubernetes-e2e-test-images/echoserver:2.2` - думаю из-за архитектуры (у меня arm, там есть сборка, но работать она не хочет😔), использовал аналогичный `ealen/echo-server:latest`.

## Task 1

```bash
vi:~/ $ kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
hello-world    1/1     Running   0          2m17s
vi:~/ $ port-forward hello-world :80
Forwarding from 127.0.0.1:53784 -> 80
Forwarding from [::1]:53784 -> 80
Handling connection for 53784
vi:~/ $ curl 127.0.0.1:53784
{"host":{"hostname":"127.0.0.1","ip":"::ffff:127.0.0.1","ips":[]},"http":{"method":"GET","baseUrl":"","originalUrl":"/","protocol":"http"},"request":{"params":{"0":"/"},"query":{},"cookies":{},"body":{},"headers":{"host":"127.0.0.1:53784","user-agent":"curl/7.87.0","accept":"*/*"}},"environment":{"PATH":"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin","HOSTNAME":"hello-world","KUBERNETES_PORT_443_TCP_PROTO":"tcp","KUBERNETES_PORT_443_TCP_PORT":"443","KUBERNETES_PORT_443_TCP_ADDR":"10.96.0.1","KUBERNETES_SERVICE_HOST":"10.96.0.1","KUBERNETES_SERVICE_PORT":"443","KUBERNETES_SERVICE_PORT_HTTPS":"443","KUBERNETES_PORT":"tcp://10.96.0.1:443","KUBERNETES_PORT_443_TCP":"tcp://10.96.0.1:443","NODE_VERSION":"16.16.0","YARN_VERSION":"1.22.19","HOME":"/root"}}%
```

[Конфиг](src/hello-world-pod.yaml) пода.

## Task 2

```bash
vi:~/ $ kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
hello-world    1/1     Running   0          4m35s
netology-web   1/1     Running   0          4m20s
vi:~/ $ kubectl get services
NAME           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
kubernetes     ClusterIP   10.96.0.1        <none>        443/TCP   3d3h
netology-svc   ClusterIP   10.111.144.198   <none>        81/TCP    4m36s
vi:~/ $ kubectl port-forward svc/netology-svc :81
Forwarding from 127.0.0.1:53793 -> 80
Forwarding from [::1]:53793 -> 80
Handling connection for 53793
vi:~/ $ curl 127.0.0.1:53793
{"host":{"hostname":"127.0.0.1","ip":"::ffff:127.0.0.1","ips":[]},"http":{"method":"GET","baseUrl":"","originalUrl":"/","protocol":"http"},"request":{"params":{"0":"/"},"query":{},"cookies":{},"body":{},"headers":{"host":"127.0.0.1:53793","user-agent":"curl/7.87.0","accept":"*/*"}},"environment":{"PATH":"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin","HOSTNAME":"netology-web","NETOLOGY_SVC_SERVICE_PORT":"81","KUBERNETES_PORT_443_TCP":"tcp://10.96.0.1:443","KUBERNETES_PORT_443_TCP_PROTO":"tcp","KUBERNETES_PORT":"tcp://10.96.0.1:443","KUBERNETES_PORT_443_TCP_PORT":"443","KUBERNETES_PORT_443_TCP_ADDR":"10.96.0.1","NETOLOGY_SVC_PORT_81_TCP":"tcp://10.111.144.198:81","NETOLOGY_SVC_PORT_81_TCP_PROTO":"tcp","KUBERNETES_SERVICE_PORT":"443","KUBERNETES_SERVICE_PORT_HTTPS":"443","NETOLOGY_SVC_PORT":"tcp://10.111.144.198:81","NETOLOGY_SVC_PORT_81_TCP_PORT":"81","NETOLOGY_SVC_PORT_81_TCP_ADDR":"10.111.144.198","KUBERNETES_SERVICE_HOST":"10.96.0.1","NETOLOGY_SVC_SERVICE_HOST":"10.111.144.198","NODE_VERSION":"16.16.0","YARN_VERSION":"1.22.19","HOME":"/root"}}
```

[Конфиг](src/netology-web-pod-and-service.yaml) пода и сервиса.