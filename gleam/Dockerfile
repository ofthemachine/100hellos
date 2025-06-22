# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Add both edge repositories to ensure dependency resolution
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" | sudo tee -a /etc/apk/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" | sudo tee -a /etc/apk/repositories

# Update package lists and install Gleam and Erlang
RUN sudo apk update
RUN sudo apk add --no-cache gleam erlang

COPY --chown=human:human ./files /hello-world
