#!/bin/sh
su -m www -c php\ ``/usr/local/www/nextcloud/occ\ "$*"``
