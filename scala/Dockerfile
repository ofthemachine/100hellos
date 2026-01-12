# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/100-java11:local

RUN sudo \
  apk add --no-cache \
    gcompat bash

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENV CI_DISABLE_PROGRESS_BAR=1 \
    COURSIER_PROGRESS=0 \
    COURSIER_NO_TERM=1

ENTRYPOINT [ "/fraglet-entrypoint" ]
