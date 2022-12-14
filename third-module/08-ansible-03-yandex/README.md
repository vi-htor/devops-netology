# Tasks

Сетапить всё руками как-то скучно, поэтому задействовал terraform.  
Соответственно, сначала, tf поднимает 3 ноды `AlmaLinux 9` ([clickhouse](src/terraform/01clickhouse.tf), [vector](src/terraform/02vector.tf), [lighthouse](src/terraform/03lighthouse.tf)) и формирует inventory-файл для ansible ([inventory.tf](src/terraform/inventory.tf)). После чего, спустя 100 секунд запускается плейбук ansible ([ansible.tf](src/terraform/ansible.tf)) и в конце выдаются внутренние и внешние ip поднятых vm([output](src/terraform/output.tf)).  

Данный [плейбук](src/ansible/test.yml) предназначен для установки `Clickhouse`, `Lighthouse` и `Vector` на хосты, указанные в сформированном `inventory` файле.  
Состоит из трёх `play`:  
  * `Install Clickhouse` - для хоста `clickhouse`, устанавливает и запускает `clickhouse`;  
  * `Install Vector` - для хоста `vector`, устанавливает и запускает `vector`;  
  * `Install Lighthouse` - для хоста `lighthouse`, устанавливает и запускает `vector`.  

Немного вывода работы `terraform apply`:
```bash
null_resource.cluster (local-exec): PLAY RECAP *********************************************************************
null_resource.cluster (local-exec): clickhouse.netology.cloud  : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
null_resource.cluster (local-exec): lighthouse.netology.cloud  : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
null_resource.cluster (local-exec): vector.netology.cloud      : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

null_resource.cluster: Creation complete after 3m26s [id=8163554510414409398]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_clickhouse_yandex_cloud = "51.250.5.70"
external_ip_address_lighthouse_yandex_cloud = "62.84.127.210"
external_ip_address_vector_yandex_cloud = "84.201.128.126"
internal_ip_address_clickhouse_yandex_cloud = "192.168.101.24"
internal_ip_address_lighthouse_yandex_cloud = "192.168.101.6"
internal_ip_address_vector_yandex_cloud = "192.168.101.17"
```