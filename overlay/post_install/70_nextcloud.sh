#!/bin/sh

# workaround for app-pkg
sed -i '' "s|false|true|g" /usr/local/www/nextcloud/config/config.php

# Permissions
mkdir -p /usr/local/www/nextcloud-sessions-tmp
chmod o-rwx /usr/local/www/nextcloud-sessions-tmp
chown -R www:www /usr/local/www/nextcloud-sessions-tmp
chmod -R o-rwx /usr/local/www/nextcloud

# Updater needs this
chown -R www:www /usr/local/www/nextcloud

# Is this php-fpm or nextcloud?
sed -i '' "s/MAX_SPARE_SERVERS/`sysctl -n kern.smp.cpus`/g" /usr/local/etc/php-fpm.d/nextcloud.conf

# MySQL Configuration
# https://docs.nextcloud.com/server/13/admin_manual/installation/installation_wizard.html do not use the same name for user and db

export LC_ALL=C
NC_USER=nextcloud_admin
NC_PASS=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 25`
CFG=/root/plugin_config
# Save the config values
sysrc -f ${CFG} nextcloud_user="${NC_USER}"
sysrc -f ${CFG} nextcloud_pass="${NC_PASS}"

DB=`sysrc -f ${CFG} -n mysql_db`
DB_USER=`sysrc -f ${CFG} -n mysql_user`
DB_PASS=`sysrc -f ${CFG} -n mysql_pass`

echo "Installing NextCloud"
/root/occ.sh maintenance:install \
    --database=mysql \
    --database-name="${DB}" \
    --database-host="localhost:/tmp/mysql.sock" \
    --database-user="${DB_USER}" \
    --database-pass="${DB_PASS}" \
    --admin-user="${NC_USER}" \
    --admin-pass="${NC_PASS}"
