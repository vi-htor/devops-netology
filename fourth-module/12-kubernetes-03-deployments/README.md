## Task 1

[Deployment](src/1-1-multi-deployment.yaml)

Ошибка, видимо, была в том, что multitool тоже использует nginx и эти контейнеры конфликтуют по портам, сменил порты multitool'а на другие и всё заработало.

```bash
vi:src/ $ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
multi-deployment   1/1     1            1           16s
vi:src/ $ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
multi-deployment-6d876fb556-tbfvn   2/2     Running   0          18s
vi:src/ $ kubectl scale deployment/multi-deployment --replicas=2 
deployment.apps/multi-deployment scaled
vi:src/ $ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
multi-deployment-6d876fb556-fc549   2/2     Running   0          34s
multi-deployment-6d876fb556-tbfvn   2/2     Running   0          4m26s
vi:src/ $ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
multi-deployment   2/2     2            2           4m23s
```

Создал отдельный [pod](src/1-2-solo-pod.yaml), зашёл в него и проверил доступ с помощью `curl`:
```bash
vi:src/ $ kubectl apply -f solo-pod.yaml
pod/multitool created
vi:src/ $ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
multi-deployment-6d876fb556-fc549   2/2     Running   0          5m40s
multi-deployment-6d876fb556-tbfvn   2/2     Running   0          9m32s
multitool                           1/1     Running   0          18s
vi:src/ $ kubectl exec -it multitool /bin/bash
bash-5.1# curl multi-deployment-svc:80
<!DOCTYPE html>
<...>
<title>Welcome to nginx!</title> # пропустил вывод, там стандартная страничка nginx
<...> 
bash-5.1# curl multi-deployment-svc:1180
WBITT Network MultiTool (with NGINX) - multi-deployment-6d876fb556-fc549 - 10.1.0.61 - HTTP: 1180 , HTTPS: 11443 . (Formerly praqma/network-multitool)
```

## Task 2

Создал [deployment](src/2-1-nginx-deployment.yaml) и [service](src/2-2-nginx-service.yaml), выводы команд:

```bash
vi:src/ $ kubectl apply -f 2-1-nginx-deployment.yaml
deployment.apps/nginx-deployment created
vi:src/ $ kubectl get pods
NAME                                READY   STATUS     RESTARTS   AGE
nginx-deployment-5956948f4f-np5ss   0/1     Init:0/1   0          2m11s
vi:src/ $ kubectl apply -f 2-2-nginx-service.yaml
service/nginx-deployment-svc created
vi:src/ $ kubectl get pods
NAME                                READY   STATUS            RESTARTS   AGE
nginx-deployment-5956948f4f-np5ss   0/1     PodInitializing   0          2m42s
vi:src/ $ kubectl get pods
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-5956948f4f-np5ss   1/1     Running   0          2m43s
```