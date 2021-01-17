#!/bin/sh

echo "${CRON_SCHEDULE}    /backup.sh" > /etc/crontabs/root

/usr/sbin/crond -f
