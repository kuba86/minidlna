FROM alpine:3.18.2


LABEL org.opencontainers.image.version=v1.3.2
LABEL org.opencontainers.image.title="minidlna"
LABEL org.opencontainers.image.description="minidlna server in a container"
LABEL org.opencontainers.image.url="https://github.com/kuba86/minidlna"
LABEL org.opencontainers.image.documentation="https://github.com/kuba86/minidlna/wiki"
LABEL org.opencontainers.image.authors="kuba86"
LABEL org.opencontainers.image.licenses=Apache-2.0
LABEL org.opencontainers.image.source="https://github.com/kuba86/minidlna"
LABEL org.opencontainers.image.base.name="docker.io/library/alpine:3.18.0"



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
