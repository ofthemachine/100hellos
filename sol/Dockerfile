# syntax=docker/dockerfile:1
# escape=\
FROM blinknlights/sol-compiler:latest AS sol-compiler

COPY ./files/hello-world.sl /build/hello-world.sl
RUN mkdir -p /build/sol/core && cp -r /usr/local/lib/sol/core/* /build/sol/core/
RUN cd /build && sol -o /build/hello hello-world.sl

FROM 100hellos/000-base:local

RUN sudo apk add --no-cache gcc musl-dev

COPY --from=sol-compiler /usr/local/bin/sol /usr/local/bin/sol
COPY --from=sol-compiler /usr/local/lib/libsol_runtime.a /usr/local/lib/libsol_runtime.a
COPY --from=sol-compiler /usr/local/lib/sol /usr/local/lib/sol
COPY --from=sol-compiler /build/hello /hello-world/hello

COPY --chown=human:human ./files /hello-world
RUN ln -sf /usr/local/lib/sol /hello-world/sol

COPY --chown=human:human ./fraglet /
ENTRYPOINT [ "/fraglet-entrypoint" ]
