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