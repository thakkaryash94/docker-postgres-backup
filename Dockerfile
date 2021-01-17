FROM alpine

RUN apk add --no-cache tini postgresql-client

RUN apk add s3cmd --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

COPY backup.sh entrypoint.sh /

RUN chmod +x backup.sh entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--"]

VOLUME [ "/backups" ]

# Run your program under Tini
CMD ["/entrypoint.sh"]
