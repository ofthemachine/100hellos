# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Add edge repositories to get PicoLisp
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" | sudo tee -a /etc/apk/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" | sudo tee -a /etc/apk/repositories

# Update package lists and install PicoLisp
RUN sudo apk update
RUN sudo apk add --no-cache picolisp

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
