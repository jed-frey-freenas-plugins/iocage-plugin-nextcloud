#!/bin/sh
sysrc -f /etc/rc.conf nginx_enable="YES"

# SSL is good M'kay?
HOST=`tail -n1 /etc/hosts | cut -f2`

# Generate SSL Certs
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt -subj "/C=GB/ST=London/L=London/O=FreeNAS Jail/OU=FreeNAS Jail/CN=${HOST}.local"
openssl dhparam -out /etc/ssl/dhparam.pem 1024

service nginx restart 2>/dev/null