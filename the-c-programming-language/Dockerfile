# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/001-base:local

RUN sudo \
  apk add --no-cache \
    linux-headers \
    gcc \
    musl-dev \
    bash

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /
