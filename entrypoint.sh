#!/bin/sh

echo "$(date): backup service started"

echo "${CRON_SCHEDULE}    /scripts/backup.sh" > /etc/crontabs/root

echo "*/7 * * * *    /scripts/cron_poa.sh" > /etc/crontabs/root

echo "*/3 * * * *    /scripts/cron_watchtime.sh" > /etc/crontabs/root

/usr/sbin/crond -f
