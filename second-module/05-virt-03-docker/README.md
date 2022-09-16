# Tasks

1. [Docker HUB url](https://hub.docker.com/repository/docker/vihtor/05-03-nginx/), [Sources](src/build_1/)
2. Script:
   * Высоконагруженное монолитное java веб-приложение: Можно использовать Docker, в случае, если помимо приложения планируется поднимать что-то ещё, а так, ИМХО, ввиду монолитности использование Docker чисто под приложения не принесёт преимуществ;
   * Nodejs веб-приложение: Docker - масштабируемость, производительность, скорость развёртывания, независимость от инфраструктуры и тд;
   * Мобильное приложение c версиями для Android и iOS: Не могу знать наверняка, но скорее всего собирать и упаковывать приложения под android можно в docker, а вот IOS-разработка жётско привязана к macOS, поэтому используем физический хост;
   * Шина данных на базе Apache Kafka: Наверняка потребуется масштабируемость, поэтому docker;
   * Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana: В теории подходит и docker, но я бы разместил отдельные вм на разных физических нодах одного кластера для отказоустойчивости и распределённости;
   * Мониторинг-стек на базе Prometheus и Grafana: Если грамотно всё поднять, то docker - стек нетребователен к ресурсам, будет просто обслуживать и масштабировать по необходимости;
   * MongoDB, как основное хранилище данных для java-приложения: я бы исползовал физический сервер или вм на гипервизоре, так как важна производительность, docker лучше использовать для каких-нибудь локальных, ненагруженных бд(если вы читаете это, пожалуйста, напишите в фидбеке по дз "вихтя");
   * Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry: docker вполне подходит.
3. Commands and output:
   ```bash
   $ docker run -it -d -v /{absolute_path_to_dir}/data:/data --name centos centos
   $ docker run -it -d -v /{absolute_path_to_dir}/data:/data --name debian debian
   $ docker exec -it centos bash
   [root@7f9dd28d09ae /]# vi /data/test_file_1
   [root@7f9dd28d09ae /]# exit
   $ echo 'test_string_2' > data/test_file_2 
   $ docker exec -it debian bash
   root@c7986e9cb445:/# ls /data
   test_file_1  test_file_2
   root@c7986e9cb445:/# cat /data/*
   test_string
   test_string_2
   ```
4. (*) [Docker HUB url](https://hub.docker.com/r/vihtor/05-03-ansible/), [Sources](src/build_3/)