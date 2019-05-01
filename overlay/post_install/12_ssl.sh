#!/bin/sh

HOST=`sysrc -n hostname`

# Generate SSL Certs
/usr/bin/openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/selfsigned.key -out /etc/ssl/selfsigned.crt -subj "/C=GB/ST=${HOST}/L=${HOST}/O=${HOST}/OU=${HOST}/CN=${HOST}"
/usr/bin/openssl dhparam -out /etc/ssl/dhparam.pem 1024
