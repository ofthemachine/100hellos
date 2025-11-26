FROM 100hellos/000-base:local

ARG FRAGLET_VERSION=v0.3.0
COPY --chown=human:human ./checksums.txt /checksums.txt

# Download and verify fraglet-entrypoint
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
        echo "SHA256 checksum verification failed!" && exit 1; \
    fi && \
    sudo mv /tmp/fraglet-entrypoint /fraglet-entrypoint && \
    sudo chmod +x /fraglet-entrypoint && \
    sudo chown human:human /fraglet-entrypoint && \
    sudo mv /checksums.txt /fraglet-entrypoint.checksums.txt && \
    sudo chown human:human /fraglet-entrypoint.checksums.txt

RUN sudo \
  apk add --no-cache \
    openjdk11

ENTRYPOINT [ "/fraglet-entrypoint" ]
