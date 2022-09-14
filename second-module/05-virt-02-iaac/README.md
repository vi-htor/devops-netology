# Answers to questions

1. Преимущества IaaC: Скорость (автоматизация рутинных задач), легкая масштабируемость, безопасность, легкий откат, повышенная отказоустойчивость, идентичность инфраструктуры.  
   
   Основопологающий принцип - идемпотентность - получение одинакового результата при повторе одной и той же операции.

2. Преимущества Ansible:
      * Скорость – быстрый старт на текущей SSH инфраструктуре. (другие системы управления конфигурациями требуют установки специального окружения)
      * Простота – декларативный метод описания конфигураций.
      * Функционал - большое количество готовых к использыванию модулей.
      * Расширяемость — лёгкое подключение кастомных ролей и модулей.  

   Push или pull: Очевидно, что следует использовать наиболее подходящий к конкретному случаю подход. Сложно судить о надёжности того или иного подхода без конкретики, но пускай уж будет push за счёт некой централизованой точки распределения.

3. Нууу, на mac с apple silicon нет адекватной возможности поставить VirtualBox, поэтому буду пробовать работать c VMWare Fusion (но vb доступен на win-хосте). Итак:
   * Ansible:
     ```bash
     $ ansible --version
     ansible [core 2.13.3]
     config file = None
     configured module search path = ['/Users/htor/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
     ansible python module location = /opt/homebrew/Cellar/ansible/6.3.0/libexec/lib/python3.10/site-packages/ansible
     ansible collection location = /Users/htor/.ansible/collections:/usr/share/ansible/collections
     executable location = /opt/homebrew/Cellar/ansible/6.3.0/bin/ansible
     python version = 3.10.6 (main, Aug 30 2022, 04:58:14) [Clang 13.1.6 (clang-1316.0.21.2.5)]
     jinja version = 3.1.2
     libyaml = True
     ```
   * Vagrant:
     ```bash
     $ vagrant --version
     Vagrant 2.3.0
     ```
   * Fusion (cli для управления вм, как вывести версию - не нашёл):
     ```bash
     $ vmrun list
     Total running VMs: 0
     ```

4. Уф, пришлось повозится с этим Fusion и адекватной работой плейбука, но всё ок (Если интересно, Vagrantfile и конфиги Ansible лежат в репозитории):
   ```bash
   <...>
   ==> server1.netology: Running provisioner: ansible...
    server1.netology: Running ansible-playbook...

   PLAY [nodes] *******************************************************************

   TASK [Gathering Facts] *********************************************************
   ok: [server1.netology]

   TASK [Create directory for ssh-keys] *******************************************
   ok: [server1.netology]

   TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
   changed: [server1.netology]

   TASK [Checking DNS] ************************************************************
   changed: [server1.netology]

   TASK [Installing tools] ********************************************************
   ok: [server1.netology] => (item=git)
   ok: [server1.netology] => (item=curl)

   TASK [Installing docker] *******************************************************
   changed: [server1.netology]

   TASK [Add the current user to docker group] ************************************
   changed: [server1.netology]

   PLAY RECAP *********************************************************************
   server1.netology           : ok=7    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
   vagrant@server1:~$ docker ps
   CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
   ```