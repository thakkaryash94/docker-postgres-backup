FROM alpine

RUN apk add --no-cache tini postgresql-client curl

RUN apk add s3cmd --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

COPY entrypoint.sh /
COPY scripts /scripts

RUN chmod +x entrypoint.sh
RUN find /scripts/ -type f -iname "*.sh" -exec chmod +x {} \;

ENTRYPOINT ["/sbin/tini", "--"]

VOLUME [ "/backups" ]

# Run your program under Tini
CMD ["/entrypoint.sh"]
