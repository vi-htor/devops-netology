## Task 1

[Deployment](src/1-deployment.yaml)

Выводы команд:
```bash
vi:src/ $ kubectl get deployments
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
task-1   1/1     1            1           74s
vi:src/ $ kubectl get pods
NAME                      READY   STATUS    RESTARTS   AGE
task-1-7bc7555f5f-x25t8   2/2     Running   0          98s
vi:src/ $ kubectl exec -it task-1-7bc7555f5f-x25t8 /bin/bash
Defaulted container "multitool" out of: multitool, busybox
bash-5.1# cat input/success.txt 
22-04-2023 14:21:16
22-04-2023 14:21:26
bash-5.1# cat input/success.txt 
22-04-2023 14:21:16
22-04-2023 14:21:26
22-04-2023 14:21:36
22-04-2023 14:21:47
```

## Task 2

[Daemon Set](src/2-daemon-set.yaml)
Так как я использую Kubernetes on Docker Desktop плюс ввиду особенностей системы, у меня нет файла `/var/log/syslog`, поэтому обеспечивал возможность чтения другого локального файла.

Выводы команд:
```bash
vi:src/ $ kubectl get ds
NAME     DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
task-2   1         1         1       1            1           <none>          18s
vi:src/ $ kubectl get pods
NAME                      READY   STATUS    RESTARTS   AGE
task-2-vwvhc              1/1     Running   0          20s
vi:src/ $ kubectl exec -it task-2-vwvhc /bin/bash
bash-5.1# cat test.log 
test1
test2
test4
not_test
```