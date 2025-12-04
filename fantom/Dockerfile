# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/080-java8:local

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install

ENV PATH="/artifacts/fan/bin:${PATH}"

COPY --chown=human:human ./files /hello-world
