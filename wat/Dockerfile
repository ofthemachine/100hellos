# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install wasmtime from Alpine edge testing repository for musl compatibility
RUN sudo \
  apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
    wasmtime

COPY --chown=human:human ./files /hello-world
