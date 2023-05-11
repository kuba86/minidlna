FROM alpine:3.18

ADD entrypoint.sh /minidlna/
RUN apk \
    --no-cache \
    add \
    bash \
    curl \
    minidlna=1.3.2-r1 \
    tini=0.19.0-r1 \
    && chown 1000:1000 /etc/minidlna.conf \
    && chmod ugo+w /etc/minidlna.conf \
    && chown 1000:1000 -R /minidlna \
    && chmod -R 777 /minidlna \
    && mkdir /minidlna/cache \
    && chmod 777 /minidlna/cache
USER 1000
ENTRYPOINT ["/sbin/tini", "--", "/minidlna/entrypoint.sh"]
