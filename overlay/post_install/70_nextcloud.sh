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
