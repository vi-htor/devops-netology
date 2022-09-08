# Answers to questions

1. Таблица:
   | Вопрос  | Ответ                                                                                             |
   | ------------- |---------------------------------------------------------------------------------------------------|
   | Какое значение будет присвоено переменной `c`?  | `unsupported operand type(s) for +: 'int' and 'str'`, так как переменные `a` и `b` имеют разные типы |
   | Как получить для переменной `c` значение 12?  | `c = str(a) + b` |
   | Как получить для переменной `c` значение 3?  | `c = a + int(b)` | 
2. Ответ:
   ```python
   #!/usr/bin/env python3
   import os

   path = os.getcwd()
   os.chdir(path)
   bash_command = ["git status"]
   result_os = os.popen(' && '.join(bash_command)).read()
   #is_change = False
   for result in result_os.split('\n'):
       if result.find('modified') != -1:
           prepare_result = result.replace('\tmodified:   ', '')
           print(os.getcwd()+'/'+prepare_result)
   #        break
   ```
   Вывод скрипта:
   ```bash
   /somepath/$ ./homework4.2/script1.sh
   /<full_path>/homework4.2/README.md
   ```
3. Скрипту можно передать директорию ввиде аргумента и он поймёт `./homework4.2/script2.sh ../netology_lections ` или можно запустить как есть и он проверит наличие директории `.git` в текущей директории и, если не обнаружит её, предложит ввести путь к директории.
   
   Сам скрипт:
   ```python
   #!/usr/bin/env python3

   import os
   import sys

   if len(sys.argv) > 1:
      path = sys.argv[1]
   elif os.path.isdir('./.git') !=True:
      print("Directory '.git' not found. Enter the repository path:")
      path = input()
   else :
       path = os.getcwd()

   os.chdir(path)
   bash_command = ["git status"]
   result_os = os.popen(' && '.join(bash_command)).read()
   for result in result_os.split('\n'):
       if result.find('modified') != -1:
           prepare_result = result.replace('\tmodified:   ', '')
           print(os.getcwd()+'/'+prepare_result)
   ```
   Вывод аналогичен выводу в предыдущем задании.
4. Скрипт:
   ```python
   #!/usr/bin/env python3

   import socket
   import time
   ip = {
       'drive.google.com': '0',
       'mail.google.com': '0',
       'google.com': '0'
   }
   
   for item in ip:
       first_ip = socket.gethostbyname(item)
       ip[item] = first_ip
   
   
   while True:
       print("------"+time.asctime()+"------")
       for item in ip:
           old_ip = ip[item]
           new_ip = socket.gethostbyname(item)
           if new_ip != old_ip:
               ip[item] = new_ip
               print("[ERROR] "+item+" IP mismatch: old IP "+old_ip+", new - "+new_ip)
           else :
               print(item + " - " + ip[item])
       time.sleep(10)
   ```
   Вывод скрипта (симитировал ситуацию смены ip):
   ```bash
   $./homework4.2/script3.sh
   ------Thu Sep  8 04:56:05 2022------
   drive.google.com - 142.250.102.194
   mail.google.com - 172.217.168.197
   google.com - 216.58.208.110
   ------Thu Sep  8 04:56:15 2022------
   [ERROR] drive.google.com IP mismatch: old IP 142.250.102.194, new - 142.251.1.194
   [ERROR] mail.google.com IP mismatch: old IP 172.217.168.197, new - 209.85.233.18
   [ERROR] google.com IP mismatch: old IP 216.58.208.110, new - 173.194.220.100
   ------Thu Sep  8 04:56:25 2022------
   drive.google.com - 142.251.1.194
   mail.google.com - 209.85.233.18
   google.com - 173.194.220.100
   ------Thu Sep  8 04:56:35 2022------
   [ERROR] drive.google.com IP mismatch: old IP 142.251.1.194, new - 142.250.102.194
   [ERROR] mail.google.com IP mismatch: old IP 209.85.233.18, new - 172.217.168.197
   [ERROR] google.com IP mismatch: old IP 173.194.220.100, new - 216.58.208.110
   ------Thu Sep  8 04:56:45 2022------
   drive.google.com - 142.250.102.194
   mail.google.com - 172.217.168.197
   google.com - 216.58.208.110
   ```