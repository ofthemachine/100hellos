# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install Poly/ML - a Standard ML implementation
RUN sudo apk add --no-cache polyml

# Copy the source files to the container
COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
