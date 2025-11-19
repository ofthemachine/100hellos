# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/001-base:local

RUN sudo \
  apk add --no-cache \
    sbcl

COPY --chown=human:human ./files /
