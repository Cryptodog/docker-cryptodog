#!/usr/bin/env sh

set -eu

cd /app

if [ "$1" = "dev" ]; then
    echo "building with race detector"
    apk add build-base
    CGO_ENABLED=1 go build -race
else
    go build
fi
