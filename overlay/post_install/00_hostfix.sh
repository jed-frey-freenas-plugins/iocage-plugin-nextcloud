#/bin/sh
OLDHOST=`sysrc -n hostname`
HOST=`echo ${OLDHOST} | sed "s/_//"`
DOMAIN=`grep search /etc/resolv.conf | awk '{ print $2 }'`

sysrc hostname=${HOST}

sed -i .bak "s/HOST/${HOST}/g" /etc/hosts
sed -i .bak "s/DOMAIN/${DOMAIN}/g" /etc/hosts
