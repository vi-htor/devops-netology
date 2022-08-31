# Answers to questions

1. Использую Keepass вместо Bitwarden и связку ключей apple, так как она сквозная и нативная.  
2. OTP настроен, но для других сервисов.
3. Вообще предпочитаю nginx, но ок, последовательность действий и конфиг для apache будут выглядить примерно так:
   ```
   apt install apache2
   a2enmod ssl
   systemctl restart apache2
   openssl req -x509 -nodes -days 365 \-newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key \-out /etc/ssl/certs/apache-selfsigned.crt
   
   cat /etc/apache2/sites-available/example.conf
   <VirtualHost *:443>
      ServerName example.com
      DocumentRoot /var/www/example.com
      
      SSLEngine on
      SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
      SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
   </VirtualHost>

   a2ensite example.conf
   apache2ctl configtest
   systemctl reload apache2
   ```
4. Проверил, мы в безопасности:
   ```
   # ./testssl.sh -U --sneaky https://pornhub.com
    Testing vulnerabilities 

    Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
    CCS (CVE-2014-0224)                       not vulnerable (OK)
    Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
    ROBOT                                     not vulnerable (OK)
    Secure Renegotiation (RFC 5746)           supported (OK)
    Secure Client-Initiated Renegotiation     not vulnerable (OK)
    CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
    BREACH (CVE-2013-3587)                    no gzip/deflate/compress/br HTTP compression (OK)  - only supplied "/" tested
    POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
    TLS_FALLBACK_SCSV (RFC 7507)              No fallback possible (OK), no protocol below TLS 1.2 offered
    SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
    FREAK (CVE-2015-0204)                     not vulnerable (OK)
    DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
    LOGJAM (CVE-2015-4000), experimental      common prime with 2048 bits detected: HAProxy (2048 bits), but no DH EXPORT ciphers
    BEAST (CVE-2011-3389)                     not vulnerable (OK), no SSL3 or TLS1
    LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
    Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
    RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)
    ```
5. Только по ключам и хожу, как пример, кусок конфига ssh-клиента на личном пк:
   ```
   Host *
   User <...>
   Port <...>
   CheckHostIP=no
   StrictHostKeyChecking=no
   UserKnownHostsFile=/dev/null
   IdentityFile /Users/<...>/Documents/<...>/my_key.rsa
   ```
   Связка ключей генерируется через `ssh-keygen`.
6. Достаточно в предыдущем примере заменить `Host *` (все хосты) на `Host hostname` и добавить строку `Hostname <ip>`.
7. `tcpdump -c 100 -w test.pcap -i eth1`
