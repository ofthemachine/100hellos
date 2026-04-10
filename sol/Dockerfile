# syntax=docker/dockerfile:1
# escape=\
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl sudo zsh jq xz-utils && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd human && \
    useradd -m -g human -s /usr/bin/zsh human && \
    echo 'human ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER human
WORKDIR /home/human
ENV HOME=/home/human
ENV PATH=/usr/local/bin:${PATH}

ARG FRAGLET_VERSION=entrypoint-v0.5.0
COPY --chown=human:human ./checksums.txt /checksums.txt
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        BINARY="fraglet-entrypoint-linux-amd64"; \
    elif [ "$ARCH" = "aarch64" ]; then \
        BINARY="fraglet-entrypoint-linux-arm64"; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    BASE_URL="https://github.com/ofthemachine/fraglet/releases/download/${FRAGLET_VERSION}" && \
    curl -L -o /tmp/fraglet-entrypoint "${BASE_URL}/${BINARY}" && \
    EXPECTED_SHA=$(grep "${BINARY}" /checksums.txt | awk '{print $1}') && \
    ACTUAL_SHA=$(sha256sum /tmp/fraglet-entrypoint | awk '{print $1}') && \
    if [ "$EXPECTED_SHA" != "$ACTUAL_SHA" ]; then \
        echo "SHA256 checksum verification failed!" && \
        echo "Expected: $EXPECTED_SHA" && \
        echo "Actual: $ACTUAL_SHA" && \
        exit 1; \
    fi && \
    sudo mv /tmp/fraglet-entrypoint /fraglet-entrypoint && \
    sudo chmod +x /fraglet-entrypoint && \
    sudo chown human:human /fraglet-entrypoint && \
    sudo mv /checksums.txt /fraglet-entrypoint.checksums.txt && \
    sudo chown human:human /fraglet-entrypoint.checksums.txt

ARG SOL_VERSION=0.1.0
ARG TARGETARCH
RUN if [ "$TARGETARCH" = "amd64" ]; then \
        ARCH="x86_64"; \
    else \
        ARCH="aarch64"; \
    fi && \
    DIR="sol-${ARCH}-linux-gnu-${SOL_VERSION}" && \
    TARBALL="${DIR}.tar.xz" && \
    BASE_URL="https://github.com/doompling/sol-releases/releases/download/v${SOL_VERSION}" && \
    curl -L -o "/tmp/${TARBALL}" "${BASE_URL}/${TARBALL}" && \
    cd /tmp && tar -xf "$TARBALL" && \
    sudo cp "$DIR/sol" /usr/local/bin/sol && \
    sudo mkdir -p /usr/local/share/sol && \
    sudo cp -r "$DIR/core" /usr/local/share/sol/core && \
    sudo rm -rf /tmp/sol*

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
