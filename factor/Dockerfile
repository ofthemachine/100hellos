# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install build dependencies for Factor
RUN sudo apk add --no-cache \
    build-base \
    gcompat

# Download Factor binary
RUN cd /tmp && \
    wget https://downloads.factorcode.org/releases/0.100/factor-linux-x86-64-0.100.tar.gz && \
    tar -xzf factor-linux-x86-64-0.100.tar.gz && \
    sudo mv factor /opt/factor && \
    sudo chown -R human:human /opt/factor

# Add Factor to PATH
ENV PATH="/opt/factor:$PATH"

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
