#!/bin/sh

echo "$(date): backup service started"

echo "${CRON_SCHEDULE}    /backup.sh" > /etc/crontabs/root

echo "*/7 * * * *    /cron_poa.sh" > /etc/crontabs/root
echo "*/3 * * * *    /cron_watchtime.sh" > /etc/crontabs/root

/usr/sbin/crond -f
