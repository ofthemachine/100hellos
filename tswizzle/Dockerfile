# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install Python3 and git (git already in base, python3 needed for TSwizzle)
RUN sudo apk add --no-cache python3 py3-pip

# Download and set up TSwizzle interpreter from upstream
RUN cd /tmp && \
    wget -O tswizzle.tar.gz https://github.com/abhilipsasahoo03/TSwizzle/archive/refs/heads/main.tar.gz && \
    tar -xzf tswizzle.tar.gz && \
    sudo mkdir -p /opt/tswizzle && \
    sudo cp -r TSwizzle-main/tswizzle/* /opt/tswizzle/ && \
    sudo chmod +x /opt/tswizzle/lang.py && \
    rm -rf /tmp/tswizzle.tar.gz /tmp/TSwizzle-main

# Add TSwizzle to PATH
ENV PATH="/opt/tswizzle:$PATH"

COPY --chown=human:human ./files /hello-world
