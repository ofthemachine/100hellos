# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install Chibi Scheme from Alpine packages
RUN sudo apk add --no-cache chibi-scheme

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
