# Answers to questions

1. Вообще, на текущий момент при установке пакета node-exporter через apt `apt install prometheus-node-exporter`, он автоматом добавляет юнит в автозагрузку `/etc/systemd/system/multi-user.target.wants/prometheus-node-exporter.service`, соответственно сервис корректно стартует при перезапуске, останавливается и перезапускается через `systemd start/stop/restart/reload`. Так же в юните уже прописан внешний файл для опций `EnvironmentFile=/etc/default/prometheus-node-exporter` - протестировал, всё работает:
   ```
   root@vagrant:~# cat /proc/641/environ
   LANG=en_US.UTF-8PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/binHOME=/var/lib/prometheusLOGNAME=prometheusUSER=prometheusINVOCATION_ID=701eec655eb447878afdd1816868abf3JOURNAL_STREAM=9:22796ARGS=
   root@vagrant:~# systemctl reload prometheus-node-exporter
   root@vagrant:~# cat /proc/2141/environ
   LANG=en_US.UTF-8PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/binHOME=/var/lib/prometheusLOGNAME=prometheusUSER=prometheusINVOCATION_ID=32363bb488cb405bb5dec0d15e15cffcJOURNAL_STREAM=9:30531ARGS=testvar=example
   ```
   upd: параметры запуска службы указываются в unit-файле (строка execstart, аргументы содержаться в переменной ARGS):
   ```
   EnvironmentFile=/etc/default/prometheus-node-exporter
   ExecStart=/usr/bin/prometheus-node-exporter $ARGS
   ```
   А переменная ARGS считывается из EnviromentFile `ARGS=""`.
2. Если говорить о базовых-базовых метриках, то:
   ```
   CPU(для каждого ядра, кроме последней метрики):
    node_cpu_seconds_total
    node_cpu_seconds_total
    node_cpu_seconds_total
    process_cpu_seconds_total
    
   RAM:
    node_memory_MemAvailable_bytes 
    node_memory_MemFree_bytes
    node_memory_MemTotal_bytes
    
   Disk(для каждого диска):
    node_disk_io_time_seconds_total{device="sda"} 
    node_disk_read_bytes_total{device="sda"} 
    node_disk_read_time_seconds_total{device="sda"} 
    node_disk_write_time_seconds_total{device="sda"}
    
   Network(для каждого интерфейса):
    node_network_receive_errs_total{device="eth0"} 
    node_network_receive_bytes_total{device="eth0"} 
    node_network_transmit_bytes_total{device="eth0"}
    node_network_transmit_errs_total{device="eth0"}
3. done, порт проброшен успешно - в целом netdata эдакое конечное решение для мониторинга конкретного хоста (хотя есть и возможность отправки метрик в какой-нибудь backend по типу graphite), метрики там схожи с теми, что собирает node-exporter, но в netdata они уже визуализированы в виде графиков и более подробно описаны.
4. Да, при том systemd корректно определяет тип виртуализации (проверил так же на vps - там выдал kvm):
   ```
   dmesg |grep virt
   [    0.001934] CPU MTRRs all blank - virtualized system.
   [    0.052952] Booting paravirtualized kernel on KVM
   [    2.057702] systemd[1]: Detected virtualization oracle.
   ```
5. Ответ:
   ```
    /sbin/sysctl -n fs.nr_open or cat /proc/sys/fs/nr_open
    1048576
   ```
   nr_open - жесткий лимит на открытые дескрипторы для ядра, поменять можно либо в рамках сессии (`sysctl -w fs.nr_open=10000000`), либо на постаянной основе в файле sysctl.conf.
   Есть схожие лимиты на пользователя:
      `ulimit -Sn` - мягкий лимит, увеличеваеся в процессе работы
      `ulimit -Hn` - жесткий лимит, по умолчанию равен так же 1048576, может быть только уменьшен (из-за ограничения на ядре)
6. Answer:
   ```
   root@vagrant:~# ps -e |grep sleep
   2271 pts/2    00:00:00 sleep
   root@vagrant:~# nsenter --target 2271 --pid --mount
   root@vagrant:/# ps aux
   USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
   root           1  0.0  0.0   5476   580 pts/2    S+   20:20   0:00 sleep 1h
   root           2  0.1  0.5   8276  5264 pts/0    S    20:22   0:00 -bash
   root          11  0.0  0.3   8888  3328 pts/0    R+   20:22   0:00 ps aux
   ```
7. Это так называемая fork-бомба — вредоносная или ошибочно написанная программа, бесконечно создающая свои копии (системным вызовом fork()), которые обычно также начинают создавать свои копии и так до бесконечности.
   Механизм стабилизации: `[   36.474497] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope`, работает по лимиту количества дочерних процессов (например, для node_exporter равен 1066). Лимит процессов на сессию задаётся через `ulimit -u`.