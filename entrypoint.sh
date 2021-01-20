#!/bin/sh

echo "$(date): backup service started"

echo "${CRON_SCHEDULE}    /backup.sh" > /etc/crontabs/root

/usr/sbin/crond -f
