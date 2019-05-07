#!/bin/sh

echo "Starting mirror"
nvd-update
#
# see https://github.com/xordiv/docker-alpine-cron
#
crond -s /var/spool/cron/crontabs -b -L /var/log/cron.log "$@" && tail -f /var/log/cron.log &

echo "Mirror started"
httpd-foreground
