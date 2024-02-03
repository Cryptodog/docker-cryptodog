FROM debian:bookworm-20231120

RUN apt-get update && apt-get -y upgrade

WORKDIR /tmp
COPY ./patch.sh .
RUN chmod +x ./patch.sh && ./patch.sh
RUN bash -c "rm -rf /tmp/ejabberd*"

COPY --chown=ejabberd:ejabberd conf/ejabberd.yml /etc/ejabberd/
ARG EJABBERD_HOSTNAME
RUN sed -i "s/{EJABBERD_HOSTNAME}/${EJABBERD_HOSTNAME}/" /etc/ejabberd/ejabberd.yml
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
