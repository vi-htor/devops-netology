# Answers to questions

1. Исправленный вариант:
   ```json
    { "info" : "Sample JSON output from our service",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : "7.1.7.5" 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
   ```
2. Script:
```python
#!/usr/bin/env python3

import socket
import time
import yaml
import json
import os

json_conf=os.path.dirname(os.path.realpath(__file__))+"/ip.json"
yaml_conf=os.path.dirname(os.path.realpath(__file__))+"/ip.yaml"

while True:
    print("------"+time.asctime()+"------")
    with open(json_conf) as json_data:
        conf = json.load(json_data)
    for host, ip in conf.items():
        old_ip = ip
        new_ip = socket.gethostbyname(host)
        if new_ip != old_ip:
            conf[host] = new_ip
            print('[ERROR] {} IP mismatch: old IP {}, new - {}'.format(host,ip,new_ip))
        else :
            print('{} - {}'.format(host,ip))
    
    with open(json_conf, "w") as json_data:
        json.dump(conf, json_data, indent=2)
    
    with open(yaml_conf, "w") as yaml_data:
        yaml_data.write(yaml.dump(conf,explicit_start=True, explicit_end=True))

    time.sleep(10)
```
   Output:
```bash
 ./first_module/04-script-03-yaml/script.sh
------Mon Sep 12 18:33:25 2022------
[ERROR] drive.google.com IP mismatch: old IP 142.251.1.194, new - 142.250.102.194
[ERROR] mail.google.com IP mismatch: old IP 209.85.233.18, new - 142.250.102.17
[ERROR] google.com IP mismatch: old IP 173.194.220.100, new - 142.250.102.138
------Mon Sep 12 18:33:36 2022------
drive.google.com - 142.250.102.194
mail.google.com - 142.250.102.17
google.com - 142.250.102.138
```
   Json-file:
```json
{
  "drive.google.com": "142.250.102.194",
  "mail.google.com": "142.250.102.83",
  "google.com": "142.250.102.138"
}
```
   Yaml-file:
```yaml
---
drive.google.com: 142.250.102.194
google.com: 142.250.102.138
mail.google.com: 142.250.102.83
...
```
   