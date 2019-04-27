#!/bin/sh

sysrc -f /etc/rc.conf php_fpm_enable="YES"

cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini
# Modify opcache settings in php.ini according to Nextcloud documentation (remove comment and set recommended value)
# https://docs.nextcloud.com/server/15/admin_manual/configuration_server/server_tuning.html#enable-php-opcache
sed -i '' 's/.*opcache.enable=.*/opcache.enable=1/' /usr/local/etc/php.ini
sed -i '' 's/.*opcache.enable_cli=.*/opcache.enable_cli=1/' /usr/local/etc/php.ini
sed -i '' 's/.*opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=8/' /usr/local/etc/php.ini
sed -i '' 's/.*opcache.max_accelerated_files=.*/opcache.max_accelerated_files=10000/' /usr/local/etc/php.ini
sed -i '' 's/.*opcache.memory_consumption=.*/opcache.memory_consumption=128/' /usr/local/etc/php.ini
sed -i '' 's/.*opcache.save_comments=.*/opcache.save_comments=1/' /usr/local/etc/php.ini
sed -i '' 's/.*opcache.revalidate_freq=.*/opcache.revalidate_freq=1/' /usr/local/etc/php.ini
# recommended value of 512MB for php memory limit (avoid warning when running occ)
# 2048M limit: Go big or go home.
sed -i '' 's/.*memory_limit.*/memory_limit=2048M/' /usr/local/etc/php.ini

rm /usr/local/etc/php-fpm.d/www.conf*

service php-fpm start
sleep 5
service php-fpm start            
sleep 5

