#!/bin/sh

echo "$(date): backup process started"

echo "$(date): pg_dump started for ${PGDATABASE}"

FILE=/backups/$PGDATABASE-$(date +\%FT\%H-%M-%S).sql.gz

pg_dump | /bin/gzip > $FILE

echo "$(date): pg_dump completed"

if [ -z "$S3_HOST" ]; then :
  else
    if [ -z "$S3_BUCKET" ] || [ -z "$S3_ACCESS_KEY" ] || [ -z "$S3_SECRET_KEY" ]; then
      echo "Some required S3 env variable(s) are missing"
    else
      echo "$(date): S3 backup uploading started"
      s3cmd put $FILE s3://$S3_BUCKET --access_key=$S3_ACCESS_KEY --secret_key=$S3_SECRET_KEY --host=$S3_HOST
      echo "$(date): S3 backup uploading completed"
      rm $FILE
      echo "$(date): local backup ${FILE} removed"
    fi
fi

echo "$(date): backup process completed"
