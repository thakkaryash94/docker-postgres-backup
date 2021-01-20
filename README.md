# Docker Postgres Backup Image

This repo contains backup postgres database using Docker image.


### Environment Variables

Every Postgres Environment variables are supported. You can read more [here](https://www.postgresql.org/docs/current/libpq-envars.html)

Below environment variables are tested.

#### Required variables

- PGHOSTADDR
- PGPORT
- PGDATABASE
- PGUSER
- PGPASSWORD

#### Optional Variables

- S3_ACCESS_KEY
- S3_SECRET_KEY
- S3_HOST
- CRON_SCHEDULE="* * * * *"

## Example

```sh
docker run -d \
      --name postgres-backup \
      -v $(pwd)/backups:/backups \
      -e PGHOST=postgresql
      -e PGPORT=5432
      -e PGDATABASE=db_name
      -e PGUSER=postgres
      -e PGPASSWORD=password
      -e S3_ACCESS_KEY=ACCESS_KEY
      -e S3_SECRET_KEY=SECRET_KEY
      -e S3_BUCKET=BUCKET
      -e S3_HOST=https://storage.googleapis.com || s3.eu-west-1.amazonaws.com
      -e CRON_SCHEDULE="@daily"
      docker.pkg.github.com/thakkaryash94/docker-postgres-backup/docker-postgres-backup:latest
```
