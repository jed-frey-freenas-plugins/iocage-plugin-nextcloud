#!/bin/sh
CFG=/usr/local/etc/redis.conf

diff ${CFG} ${CFG}.sample

service redis start
