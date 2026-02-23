# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/300-node:local

RUN sudo npm install -g coffee-script

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
