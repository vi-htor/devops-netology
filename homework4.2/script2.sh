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