## Task 1

[Deployment](src/1-deployment.yaml), [PV and PVC](src/1-pv-and-pvc.yaml)

<details>
    <summary>Выводы команд:</summary>

    ```bash
    # Проверяем, что директория пуста
    vi:src/ $ ls test
    vi:src/ $
    # Поднимаем deployment
    vi:src/ $ kubectl apply -f 1-deployment.yaml
    deployment.apps/task-1 created
    # Директория пуста, а Pod в статусе Pending
    vi:src/ $ kubectl get deployments
    NAME     READY   UP-TO-DATE   AVAILABLE   AGE
    task-1   0/1     1            0           47s
    vi:src/ $ kubectl get pods
    NAME                     READY   STATUS    RESTARTS   AGE
    task-1-58c468545-rfmfv   0/2     Pending   0          54s
    # Поднимаем pv и pvc
    vi:src/ $ kubectl apply -f 1-pv-and-pvc.yaml
    persistentvolume/pv created
    persistentvolumeclaim/pvc created
    # Pod поднялся, в директории появился файл
    vi:src/ $ kubectl get deployments
    NAME     READY   UP-TO-DATE   AVAILABLE   AGE
    task-1   1/1     1            1           2m23s
    vi:src/ $ kubectl get pods
    NAME                     READY   STATUS    RESTARTS   AGE
    task-1-58c468545-rfmfv   2/2     Running   0          2m24s
    vi:src/ $ kubectl get pv
    NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
    pv     10Mi       RWO            Recycle          Bound    default/pvc                           50s
    vi:src/ $ kubectl get pvc
    NAME   STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
    pvc    Bound    pv       10Mi       RWO                           53s
    vi:src/ $ ls test 
    success.txt
    vi:src/ $ cat test/success.txt
    11-05-2023 21:05:09
    # На всякий проверяем чтение из multitool
    vi:src/ $ kubectl exec -it task-1-58c468545-rfmfv /bin/bash
    Defaulted container "multitool" out of: multitool, busybox
    bash-5.1# cat /input/success.txt
    11-05-2023 21:05:09
    <...>
    11-05-2023 21:07:36
    # Удаляем deployment и pvc
    vi:src/ $ kubectl delete -f 1-deployment.yaml                                                                                                                                                                                [0:08:38]
    deployment.apps "task-1" deleted
    vi:src/ $ kubectl delete pvc pvc
    persistentvolumeclaim "pvc" deleted
    # Файл остался доступен, так как volume не удалён
    vi:src/ $ ls test
    success.txt
    # Удаляем pv
    vi:src/ $ kubectl delete pv pv
    persistentvolume "pv" deleted
    # Файл удалился, так как политика установлена на recycle (политика delete равно работает только с облачными провайдерами, политика retain оставила бы файл).
    ```

</details>

## Task 2

[Storage Class](src/2-sc-nfs.yaml), [PVC](src/2-pvc-nfs.yaml), [Deployment](src/2-deployment.yaml)

<details>
    <summary>Выводы команд:</summary>

    ```bash
    # Настройку nfs-сервера пропущу, это скучно
    # Провайдер nfs для microk8s использовал официальный, как и советовала документация nfs.csi.k8s.io
    vi:src/ $ kubectl apply -f 2-sc-nfs.yaml
    storageclass.storage.k8s.io/nfs-csi created
    vi:src/ $ kubectl apply -f 2-pvc-nfs.yaml
    persistentvolumeclaim/nfs-pvc created
    vi:src/ $ kubectl describe pvc nfs-pvc
    Name:          nfs-pvc
    Namespace:     default
    StorageClass:  nfs-csi
    Status:        Bound
    Volume:        pvc-8546a48f-0fa6-4716-b7dd-e1554a00a084
    Labels:        <none>
    Annotations:   pv.kubernetes.io/bind-completed: yes
                pv.kubernetes.io/bound-by-controller: yes
                volume.beta.kubernetes.io/storage-provisioner: nfs.csi.k8s.io
                volume.kubernetes.io/storage-provisioner: nfs.csi.k8s.io
    Finalizers:    [kubernetes.io/pvc-protection]
    Capacity:      10Mi
    Access Modes:  RWO
    VolumeMode:    Filesystem
    Used By:       <none>
    Events:
    Type    Reason                 Age              From                                                                  Message
    ----    ------                 ----             ----                                                                  -------
    Normal  Provisioning           3s               nfs.csi.k8s.io_local-ubuntu-arm_176706ce-d8c3-40f1-a186-27889bb1d46c  External provisioner is provisioning volume for claim "default/nfs-pvc"
    Normal  ExternalProvisioning   3s (x2 over 3s)  persistentvolume-controller                                           waiting for a volume to be created, either by external provisioner "nfs.csi.k8s.io" or manually created by system administrator
    Normal  ProvisioningSucceeded  3s               nfs.csi.k8s.io_local-ubuntu-arm_176706ce-d8c3-40f1-a186-27889bb1d46c  Successfully provisioned volume pvc-8546a48f-0fa6-4716-b7dd-e1554a00a084
    vi:src/ $ kubectl apply -f 2-deployment.yaml
    deployment.apps/task-2 created
    vi:src/ $ kubectl get pods
    NAME                      READY   STATUS    RESTARTS   AGE
    task-2-5fd46fcbd6-5j7zs   1/1     Running   0          11s
    vi:src/ $ kubectl exec -it task-2-5fd46fcbd6-5j7zs /bin/bash
    bash-5.1# touch /input/test-file
    bash-5.1# echo "test" > /input/test-file
    bash-5.1# cat /input/test-file
    test
    bash-5.1#
    # Проверил на хосте
    vi@local-ubuntu-arm:~$ cat test/pvc-8546a48f-0fa6-4716-b7dd-e1554a00a084/test-file
    test
    ```

</details>