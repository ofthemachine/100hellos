# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" | sudo tee -a /etc/apk/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" | sudo tee -a /etc/apk/repositories
RUN sudo apk add --no-cache deno

# NO CMD HERE!
COPY --chown=human:human ./files /hello-world
