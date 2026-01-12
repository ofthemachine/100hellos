FROM 100hellos/000-base:local

# Install Mercury from Alpine packages (MUSL-compatible) and gcc for compilation
RUN sudo apk add --no-cache mercury gcc musl-dev

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
