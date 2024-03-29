# Tasks

1. По пунктам:
   1. В начале, ввиду того что тз не чёткое и планируется много маленьких релизов, проще использовать `Terraform` + `Ansible` + `Docker & Docker Compose`(гибридный тип), а после, когда релизы станут более стабильными в продакшене можно перейти на шаблонизацию - `Packer + Terraform + Docker + Kubernetes` для предсказуемости, согласованности инфраструктуры и более быстрого масштабирования.
   2. Для упрощения жизни лучше использовать центральный сервер - нет необходимости устанавливать агенты + более доступные процессы аутентификации (предоставления доступов другим участникам проекта), логгирования и мониторинга.
   3. Так как в основе лежат `Ansible & Terraform` агенты, в теории, не понадабятся.
   4. В начале проще использовать и то и то (`Ansible` - управление конфигурацией, `Terraform` - средство инициализации ресурсов), а после планируется полный переход на средства инициализации ресурсов.
   5. Из уже используемых это `Packer` (Создание образов), `Terraform` (Средство инициализации ресурсов), `Docker` (Контейнеры наше всё), `Kubernetes` (Контейнерами же нужно управлять централизовано?), `Ansible` (Управление конфигурацией) и `Teamcity` (CI/CD).
   6. Из новых инструментов было бы хорошо задействовать `Grafana & Zabbix` или любые другие системы мониторинга, а так же стэк `ELK` для сбора журналов и логов. Так же было бы неплохо по максимуму перевести все bash-скрипты в плейбуки ansible, если это возможно.
2. Output:
   ```bash
   $terraform --version
   Terraform v1.3.4
   on darwin_arm6
   ```
3. В рамках текущей задачи не хочу плодить несколько версий `Terraform` у себя на основной машинке, но, поставить предыдущую версию рядом с актуальной не сложно:
   * Обычно предыдущие релизы подобных продуктов так же доступны для загрузки, поэтому просто тянем необходимый релиз с оф репозитория и распаковываем, куда удобно (например, в `/usr/local/tf/0_12/`);
   * Создаем символическую ссылку на скачанный бинарник: `ln -s /usr/local/tf/0_12/terraform /usr/bin/tf_0_12`;
   * Пользуемся им при необходимости: `$tf_0_12 --version`;
   * PROFIT!
