Изначально я думал выполнить сразу второе задание, но в процессе столкнулся с трудностью выделения cluster-ip для keepalived, и поэтому выполнил первое с некоторыми оговорками.

## Задание 1

Я установил кластер, состоящий из 3 мастер-нод и 4 рабочих (вся инфраструктура в [terraform](src/terraform/)):

```bash
# Устанавливаем необходимые пакеты
apt install python3-pip git 
# Клонируем репо kubespray
git clone https://github.com/kubernetes-sigs/kubespray
# Устанавливаем зависимости
pip3 install -r requirements.txt
# Собираем inventory и редактируем его
cp -rfp inventory/sample inventory/mycluster
declare -a IPS=(192.168.101.16 192.168.101.14 192.168.101.25 192.168.101.4 192.168.101.23 192.168.101.15 192.168.101.7)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
# Итоговый inventory
root@control-node:~/kubespray# cat inventory/mycluster/hosts.yaml
all:
  hosts:
    master-01:
      ansible_host: 192.168.101.16
      ip: 192.168.101.16
      access_ip: 192.168.101.16
      ansible_user: ubuntu
    master-02:
      ansible_host: 192.168.101.14
      ip: 192.168.101.14
      access_ip: 192.168.101.14
      ansible_user: ubuntu
    master-03:
      ansible_host: 192.168.101.25
      ip: 192.168.101.25
      access_ip: 192.168.101.25
      ansible_user: ubuntu
    worker-01:
      ansible_host: 192.168.101.4
      ip: 192.168.101.4
      access_ip: 192.168.101.4
      ansible_user: ubuntu
    worker-02:
      ansible_host: 192.168.101.23
      ip: 192.168.101.23
      access_ip: 192.168.101.23
      ansible_user: ubuntu
    worker-03:
      ansible_host: 192.168.101.15
      ip: 192.168.101.15
      access_ip: 192.168.101.15
      ansible_user: ubuntu
    worker-04:
      ansible_host: 192.168.101.7
      ip: 192.168.101.7
      access_ip: 192.168.101.7
      ansible_user: ubuntu
  children:
    kube_control_plane:
      hosts:
        master-01:
        master-02:
        master-03:
    kube_node:
      hosts:
        worker-01:
        worker-02:
        worker-03:
        worker-04:
    etcd:
      hosts:
        master-01:
        master-02:
        master-03:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
# Проверяем доступность хостов
ansible -i inventory/mycluster/hosts.yaml all -m ping
# Разворачиваем кластер
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
# Проверяем (предварительно добавив конфиг на control-node)
root@control-node:~/kubespray# kubectl get nodes
NAME        STATUS   ROLES           AGE   VERSION
master-01   Ready    control-plane   70m   v1.26.6
master-02   Ready    control-plane   69m   v1.26.6
master-03   Ready    control-plane   69m   v1.26.6
worker-01   Ready    <none>          67m   v1.26.6
worker-02   Ready    <none>          67m   v1.26.6
worker-03   Ready    <none>          67m   v1.26.6
worker-04   Ready    <none>          67m   v1.26.6
root@control-node:~/kubespray# kubectl create deploy nginx --image=nginx:latest --replicas=2
deployment.apps/nginx created
root@control-node:~/kubespray# kubectl get pod -o wide
NAME                     READY   STATUS    RESTARTS   AGE   IP              NODE        NOMINATED NODE   READINESS GATES
nginx-654975c8cd-79ftg   1/1     Running   0          17s   10.233.86.1     worker-03   <none>           <none>
nginx-654975c8cd-tg58l   1/1     Running   0          17s   10.233.75.129   worker-02   <none>           <none>
```

p.s по поводу второго задания, будь чуть больше времени, можно было бы использовать [Yandex Network Load Balancer](https://cloud.yandex.ru/docs/network-load-balancer/)