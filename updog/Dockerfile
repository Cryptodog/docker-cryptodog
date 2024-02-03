FROM golang:alpine3.19

# Grabbing potentially untrustworthy code here
RUN mkdir /app && wget -O - https://github.com/Cryptodog/updog/archive/deploy.tar.gz | tar -C /app --strip 1 -xzf -

WORKDIR /app
RUN go mod init github.com/Cryptodog/updog && go mod tidy && go build
COPY conf/config.json /app

RUN addgroup -S updog && adduser -S updog -G updog
USER updog
ENTRYPOINT ["/app/updog"]
