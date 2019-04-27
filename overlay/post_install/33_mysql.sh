#!/bin/sh

# Enable the service & disable networking.
echo "- Enable MySQL"
sysrc -f /etc/rc.conf mysql_enable="YES"
sysrc -f /etc/rc.conf mysql_args="--skip-networking"

# Start the service
echo "- Start MySQL"
service mysql-server start
# Give it a second.
sleep 5

## Nextcloud Config
# https://docs.nextcloud.com/server/13/admin_manual/installation/installation_wizard.html do not use the same name for user and db
USER="dbadmin"
DB="nextcloud"
export LC_ALL=C
PASS=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1`
# Save the config values
echo "dbname:${DB}" > /root/plugin_config
echo "dbuser:${USER}" >> /root/plugin_config
echo "dbpass:${PASS}" >> /root/plugin_config

# Configure mysql
mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('${PASS}') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';

CREATE USER '${USER}'@'localhost' IDENTIFIED BY '${PASS}';
GRANT ALL PRIVILEGES ON *.* TO '${USER}'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ${DB}.* TO '${USER}'@'localhost';
FLUSH PRIVILEGES;
EOF
