FROM alpine:3.24.1

RUN apk add --no-cache tini bash postgresql18-client ca-certificates curl \
    && curl -sL https://dl.min.io/client/mc/release/linux-amd64/mc -o /usr/local/bin/mc \
    && chmod +x /usr/local/bin/mc \
    && apk del curl

COPY entrypoint.sh backup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/backup.sh

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/usr/local/bin/entrypoint.sh"]