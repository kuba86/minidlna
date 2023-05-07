FROM alpine:latest

ADD entrypoint.sh /minidlna/
RUN apk --no-cache add bash curl minidlna tini \
    && chown 1000:1000 /etc/minidlna.conf \
    && chmod ugo+w /etc/minidlna.conf \
    && chown 1000:1000 -R /minidlna \
    && chmod -R 777 /minidlna \
    && mkdir /minidlna/cache \
    && chmod 777 /minidlna/cache
USER 1000
ENTRYPOINT ["/sbin/tini", "--", "/minidlna/entrypoint.sh"]
