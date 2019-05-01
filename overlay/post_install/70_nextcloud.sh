#!/bin/sh

# Nextcloud Admin Account
NC_USER=nextcloud_admin
NC_PASS=`LC_ALL=C head /dev/urandom | tr -dc A-Za-z0-9 | head -c 25`
CFG=/root/plugin_config
sysrc -f ${CFG} nextcloud_user="${NC_USER}"
sysrc -f ${CFG} nextcloud_pass="${NC_PASS}"

# Permissions
mkdir -p /usr/local/www/nextcloud-sessions-tmp
chmod o-rwx /usr/local/www/nextcloud-sessions-tmp
chown -R www:www /usr/local/www/nextcloud-sessions-tmp
chmod -R o-rwx /usr/local/www/nextcloud
# Updater needs this
chown -R www:www /usr/local/www/nextcloud
