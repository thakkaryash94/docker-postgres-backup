#!/bin/bash
set -e

required_vars="PGHOST PGPORT PGDATABASE PGUSER PGPASSWORD S3_HOST S3_BUCKET S3_ACCESS_KEY S3_SECRET_KEY"
for var in $required_vars; do
    if [ -z "${!var}" ]; then
        echo "ERROR: $var is not set" >&2
        exit 1
    fi
done

mc alias set default "$S3_HOST" "$S3_ACCESS_KEY" "$S3_SECRET_KEY" --api S3v4

if [ -z "$CRON_SCHEDULE" ]; then
    echo "No CRON_SCHEDULE set. Running backup once..."
    exec /usr/local/bin/backup.sh
fi

# Build crontab with env vars baked in (busybox crond doesn't inherit them)
{
    echo "PGHOST='$PGHOST'"
    echo "PGPORT='$PGPORT'"
    echo "PGDATABASE='$PGDATABASE'"
    echo "PGUSER='$PGUSER'"
    echo "PGPASSWORD='$PGPASSWORD'"
    echo "S3_HOST='$S3_HOST'"
    echo "S3_BUCKET='$S3_BUCKET'"
    echo "S3_ACCESS_KEY='$S3_ACCESS_KEY'"
    echo "S3_SECRET_KEY='$S3_SECRET_KEY'"
    echo "$CRON_SCHEDULE /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1"
} > /etc/crontabs/root

touch /var/log/backup.log

# Tail logs in background so Docker shows them
tail -f /var/log/backup.log &

echo "Installing cron job: $CRON_SCHEDULE"
echo "Starting crond..."

exec crond -f -l 2