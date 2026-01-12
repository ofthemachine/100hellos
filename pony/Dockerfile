# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install dependencies for ponyup and running pony
RUN sudo apk add --no-cache \
    curl \
    bash \
    gcc \
    musl-dev \
    clang \
    binutils-gold

# Install ponyup and then ponyc
RUN curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ponylang/ponyup/latest-release/ponyup-init.sh | bash && \
    export PATH=/home/human/.local/share/ponyup/bin:$PATH && \
    ponyup update ponyc release && \
    sudo ln -s /home/human/.local/share/ponyup/bin/ponyc /usr/local/bin/ponyc

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
