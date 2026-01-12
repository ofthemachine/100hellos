# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Download Zig stable release, extract it, and move it into /usr/local/zig (requires sudo).
ARG ZIG_VERSION=0.12.0
RUN curl -L -o /tmp/zig.tar.xz https://ziglang.org/download/${ZIG_VERSION}/zig-linux-x86_64-${ZIG_VERSION}.tar.xz && \
    cd /tmp && \
    tar -xvf zig.tar.xz && \
    sudo mv zig-linux-x86_64-${ZIG_VERSION} /usr/local/zig && \
    sudo ln -s /usr/local/zig/zig /usr/local/bin/zig

ENV PATH=/usr/local/zig:$PATH

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
