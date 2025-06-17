# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Add edge repositories to get a supported LLVM version (16 is not supported by Odin)
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" | sudo tee -a /etc/apk/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" | sudo tee -a /etc/apk/repositories

# Install LLVM and Clang for building Odin (git and make already in base)
RUN sudo apk update
RUN sudo apk add --no-cache \
    llvm-dev \
    clang

# Create directory and clone/build Odin from source
RUN sudo mkdir -p /opt/odin && sudo chown human:human /opt/odin
RUN git clone https://github.com/odin-lang/Odin.git /opt/odin && \
    cd /opt/odin && \
    make release && \
    sudo cp odin /usr/local/bin/

# Set ODIN_ROOT environment variable
ENV ODIN_ROOT=/opt/odin

# NO CMD HERE! The entrypoint will find and run hello-world.sh
COPY --chown=human:human ./files /hello-world
