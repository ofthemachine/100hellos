# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN sudo apk add --no-cache vala gcc musl-dev

COPY --chown=human:human ./files /hello-world
