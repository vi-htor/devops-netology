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
   bash_command = ["cd ./", "git status"]
   result_os = os.popen(' && '.join(bash_command)).read()
   #is_change = False
   for result in result_os.split('\n'):
       if result.find('modified') != -1:
           prepare_result = result.replace('\tmodified:   ', '')
           print(prepare_result)
   #        break
   ```