#!/bin/bash
set -e

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="${PGDATABASE}_${TIMESTAMP}.sql.gz"
S3_PATH="default/${S3_BUCKET}/${FILENAME}"

echo "[$(date)] Starting backup of $PGDATABASE..."

PGPASSWORD="$PGPASSWORD" pg_dump \
    -h "$PGHOST" \
    -p "$PGPORT" \
    -U "$PGUSER" \
    -d "$PGDATABASE" \
    --no-owner \
    --no-acl \
    | gzip \
    | mc pipe "$S3_PATH"

echo "[$(date)] Backup uploaded: s3://${S3_BUCKET}/${FILENAME}"