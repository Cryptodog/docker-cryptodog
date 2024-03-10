FROM golang:alpine3.19

# Grabbing potentially untrustworthy code here
RUN mkdir /app && wget -O - https://github.com/Cryptodog/updog/archive/refs/tags/v0.0.1.tar.gz | tar -C /app --strip 1 -xzf -

WORKDIR /app
ARG DEPLOY_ENV
COPY conf/${DEPLOY_ENV}.json /app/config.json
COPY build.sh /app
RUN chmod +x /app/build.sh && /app/build.sh ${DEPLOY_ENV}

RUN addgroup -S updog && adduser -S updog -G updog
USER updog
ENTRYPOINT ["/app/updog"]
