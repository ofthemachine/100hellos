# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install Lua and development tools needed for Fennel
RUN sudo apk add --no-cache \
    lua5.4 \
    lua5.4-dev \
    luarocks5.4

# Install Fennel via luarocks
RUN sudo luarocks-5.4 install fennel

# Create symlinks for easier usage - find fennel dynamically
RUN sudo ln -sf /usr/bin/lua5.4 /usr/local/bin/lua && \
    sudo ln -sf $(find /usr/local/lib/luarocks/rocks-5.4/fennel -name fennel -type f) /usr/local/bin/fennel

COPY --chown=human:human ./files /hello-world
