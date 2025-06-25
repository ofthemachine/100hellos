# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install build dependencies (git and make are already in base image)
RUN sudo apk add --no-cache build-base cmake python3

# Clone and build Wren
RUN git clone --depth 1 https://github.com/wren-lang/wren-cli.git /tmp/wren-cli \
    && cd /tmp/wren-cli/projects/make \
    && make \
    && sudo mv ../../bin/wren_cli /usr/local/bin/wren \
    && cd / \
    && rm -rf /tmp/wren-cli

# Copy hello world files
COPY --chown=human:human ./files /hello-world/
