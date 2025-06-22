# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install Go - TinyGo requires the Go toolchain for compilation
RUN sudo apk add --no-cache go

# Install TinyGo from official release - using the latest stable version
ARG TINYGO_VERSION=0.38.0
RUN wget -O /tmp/tinygo.tar.gz "https://github.com/tinygo-org/tinygo/releases/download/v${TINYGO_VERSION}/tinygo${TINYGO_VERSION}.linux-amd64.tar.gz" \
    && sudo tar -C /usr/local -xzf /tmp/tinygo.tar.gz \
    && rm /tmp/tinygo.tar.gz \
    && sudo ln -s /usr/local/tinygo/bin/tinygo /usr/local/bin/tinygo

# Set up environment
ENV PATH="/usr/local/tinygo/bin:${PATH}"

COPY --chown=human:human ./files /hello-world
