# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install dependencies for building CBQN
RUN sudo apk add --no-cache \
    build-base \
    git \
    libffi-dev

# Clone and build CBQN (the C implementation of BQN)
RUN cd /tmp && \
    git clone https://github.com/dzaima/CBQN.git && \
    cd CBQN && \
    make && \
    sudo cp BQN /usr/local/bin/bqn && \
    cd / && \
    rm -rf /tmp/CBQN

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
