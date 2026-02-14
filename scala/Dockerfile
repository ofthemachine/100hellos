# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/100-java11:local

RUN sudo \
  apk add --no-cache \
    gcompat bash

# Download and install Scala
RUN curl -fL https://github.com/lampepfl/dotty/releases/download/3.1.3/scala3-3.1.3.tar.gz -o /tmp/scala3-3.1.3.tar.gz && \
    echo "9e1eefdcab77b2d2a9057b3d6f78301591e9c27513c92413f3c353a77093f2d7  /tmp/scala3-3.1.3.tar.gz" | sha256sum -c - && \
    sudo tar -xzf /tmp/scala3-3.1.3.tar.gz -C /usr/local --strip-components=1 && \
    rm /tmp/scala3-3.1.3.tar.gz

ENV PATH="/usr/local/bin:${PATH}"

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENV CI_DISABLE_PROGRESS_BAR=1 \
    COURSIER_PROGRESS=0 \
    COURSIER_NO_TERM=1

ENTRYPOINT [ "/fraglet-entrypoint" ]
