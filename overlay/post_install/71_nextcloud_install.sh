#!/bin/sh
## Install Nextcloud.
# Read Configuration
CFG=/root/plugin_config
DB=`sysrc -f ${CFG} -n mysql_db`
DB_USER=`sysrc -f ${CFG} -n mysql_user`
DB_PASS=`sysrc -f ${CFG} -n mysql_pass`
NC_USER=`sysrc -f ${CFG} -n nextcloud_user`
NC_PASS=`sysrc -f ${CFG} -n nextcloud_pass`

/root/occ.sh maintenance:install \
    --database=mysql --database-name="${DB}" --database-host="localhost:/tmp/mysql.sock" --database-user="${DB_USER}" --database-pass="${DB_PASS}" --admin-user="${NC_USER}" --admin-pass="${NC_PASS}"

# Setup Trusted Hosts.
HOST=`sysrc -n hostname | tr '[:upper:]' '[:lower:]'` 
DOMAIN=`grep search /etc/resolv.conf | awk '{ print $2 }'`
IP=`ifconfig epair0b | awk '/inet/ { print $2 }'`
# By IP
/root/occ.sh config:system:set trusted_domains 0 --value="$IP"
# Bare host
/root/occ.sh config:system:set trusted_domains 1 --value="${HOST}"
# Host with domain.
/root/occ.sh config:system:set trusted_domains 2 --value="${HOST}.${DOMAIN}"
# MDNS.
/root/occ.sh config:system:set trusted_domains 3 --value="${HOST}.local"
