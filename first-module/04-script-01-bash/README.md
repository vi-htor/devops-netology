# Answers to questions

1. Таблица:
   | Переменная  | Значение | Обоснование |
   | ------------- | ------------- | ------------- |
   | `c`  | a+b  | a и b не объявленны как переменные |
   | `d`  | 1+2  | Переменны по умолчанию - это строки |
   | `e`  | 3  | Конструкция `$(())` предполагает выполнение арифметических операций |

2. Ответ:
   ```bash
   #!/bin/bash
   while ((1==1))
   do
           curl https://localhost:4757
           if (($? != 0))
           then
                   date >> curl.log
           else
                   exit
           fi
           sleep 1
   done
   ```
3. Ответ:
   ```bash
   #!/bin/bash
   hosts=(192.168.0.1 173.194.222.113 87.250.250.242)
   port=80
   for host in ${hosts[@]}
   do
       for i in {1..5}
       do
               curl -s --connect-timeout 2 http://$host:$port > /dev/null
               if (($? != 0))
               then
                  echo $(date) " | Host $host unreachable by port 80." >> hostlog.log
               else
                  echo $(date) " | Host $host availble by port 80."  >> hostlog.log
               fi
               sleep 1
       done
   done
   ```
4. Ответ:
   ```bash
   #!/bin/bash
   hosts=(192.168.0.1 173.194.222.113 87.250.250.242)
   port=80
   for host in ${hosts[@]}
   do
      for i in {1..5}
      do
            curl -s --connect-timeout 2 http://$host:$port > /dev/null
            if (($? != 0))
            then
               echo $(date) " | Error | Host $host unreachable by port 80."  > error.log
               exit 1
            else
               echo $(date) " | Host $host availble by port 80."  >> hostlog.log
            fi
            sleep 1
      done
   done
   ```