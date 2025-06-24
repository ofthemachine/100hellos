# syntax=docker/dockerfile:1
FROM 100hellos/000-base:local

# Install the Hare compiler and required dependencies (pulls in harec, qbe, etc.)
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" | sudo tee -a /etc/apk/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" | sudo tee -a /etc/apk/repositories
RUN sudo apk update
RUN sudo apk add --no-cache hare

# Copy "Hello World!" source and helper script into the container
COPY --chown=human:human ./files /hello-world
