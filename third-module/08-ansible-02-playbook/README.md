# Tasks

Данный [плейбук](playbook/site.yml) предназначен для установки `Clickhouse` и `Vector` на хосты, указанные в `inventory` файле.  
Состоит из двух `play`:  
  * `Install Clickhouse` - для группы хостов `clickhouse`, устанавливает и запускает `clickhouse`;  
  * `Install Vector` - для группы хостов `vector`, устанавливает и запускает `vector`.  

В обоих случаях для тестирования использовал контейнеризированный образ `Centos 8` + arm-версии пакетов.  