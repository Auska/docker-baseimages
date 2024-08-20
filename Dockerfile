FROM alpine:edge

LABEL maintainer="Auska"
LABEL email="luodan0709@live.cn"
LABEL version="1.0.0"

# Add s6-overlay
ENV S6_OVERLAY_VERSION=3.2.0.0
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

RUN apk add --no-cache \
    alpine-release \
    bash \
    ca-certificates \
    catatonit \
    coreutils \
    curl \
    findutils \
    jq \
    netcat-openbsd \
    procps-ng \
    shadow \
    tzdata && \
    groupmod -g 1000 users && \
    useradd -u 999 -U -d /config -s /bin/false abc && \
    usermod -G users abc && \
    mkdir -p /config /defaults && \
    rm -rf /tmp/*

ENTRYPOINT ["/init"]
