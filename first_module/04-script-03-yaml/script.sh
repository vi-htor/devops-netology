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