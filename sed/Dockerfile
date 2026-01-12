# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
