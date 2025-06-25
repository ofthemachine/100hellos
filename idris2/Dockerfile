# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install Idris2 compiler
RUN sudo apk add --no-cache idris2

COPY --chown=human:human ./files /hello-world
