FROM golang:alpine3.19

COPY conf /updater
WORKDIR /updater

ARG VERSION=0.0.4
RUN apk add minisign && \
    wget "https://github.com/ayyghost/updater/releases/download/v${VERSION}/updater-${VERSION}.tar.gz" && \
    wget "https://github.com/ayyghost/updater/releases/download/v${VERSION}/updater-${VERSION}.tar.gz.minisig" && \
    minisign -Vm "updater-${VERSION}.tar.gz" && \
    tar --strip 1 -xzf "updater-${VERSION}.tar.gz" && \
    rm "updater-${VERSION}.tar.gz"
RUN go build

RUN addgroup -S updater && adduser -S updater -G updater
# /srv needs 755 so caddy can read it
# this has to be done after caddy starts, which is why updater depends on caddy
RUN chown updater:updater /srv && chmod 755 /srv

USER updater
ENTRYPOINT ["/updater/updater"]
