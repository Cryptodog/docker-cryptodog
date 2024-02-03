FROM alpine:3.19.0

RUN apk --no-cache add tor
COPY torrc /etc/tor/torrc
ARG DEPLOY_ENV
COPY --chown=tor:tor conf/${DEPLOY_ENV}/hidden_service /var/lib/tor/hidden_service
RUN chmod 700 /var/lib/tor/hidden_service

USER tor
ENTRYPOINT ["tor"]
CMD ["-f", "/etc/tor/torrc"]
