FROM 100hellos/000-base:local

# Install build dependencies and compile Malbolge interpreter
RUN sudo apk add --no-cache gcc musl-dev
COPY --chown=human:human ./files/malbolge.c /tmp/
RUN gcc -o /usr/local/bin/malbolge /tmp/malbolge.c && rm /tmp/malbolge.c

# Copy program files
COPY --chown=human:human ./files/ /hello-world/