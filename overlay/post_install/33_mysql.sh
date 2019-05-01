#!/bin/sh

# Start the service
service mysql-server start

sleep 5

# MySQL Configuration
# https://docs.nextcloud.com/server/13/admin_manual/installation/installation_wizard.html do not use the same name for user and db
USER="dbadmin"
DB="nextcloud"
export LC_ALL=C
PASS=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 25`

CFG=/root/plugin_config
# Save the config values
sysrc -f ${CFG} mysql_db="${DB}"
sysrc -f ${CFG} mysql_user="${USER}"
sysrc -f ${CFG} mysql_pass="${PASS}"

# Round trip for proof of concept
DB=`sysrc -f ${CFG} -n mysql_db`
USER=`sysrc -f ${CFG} -n mysql_user`
PASS=`sysrc -f ${CFG} -n mysql_pass`

# Configure mysql
mysql -u root -p`tail -n1 /root/.mysql_secret` --socket=/var/run/mysql.sock --connect-expired-password <<-EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${PASS}';
CREATE DATABASE \`${DB}\` DEFAULT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
CREATE USER '${USER}'@'localhost' IDENTIFIED BY '${PASS}';
GRANT ALL PRIVILEGES ON ${DB}.* TO '${USER}'@'localhost';
FLUSH PRIVILEGES;
EOF

service mysql-server restart
