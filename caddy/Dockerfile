FROM caddy:2.7.6-alpine

COPY conf /etc/caddy
RUN addgroup -S caddy && adduser -S caddy -G caddy
RUN chown caddy:caddy /config/caddy /data/caddy
USER caddy
