# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Download, extract, and install Julia in a single layer
RUN wget https://julialang-s3.julialang.org/bin/musl/x64/1.10/julia-1.10.9-musl-x86_64.tar.gz -O /tmp/julia.tar.gz && \
    sudo tar xzf /tmp/julia.tar.gz -C /opt && \
    sudo ln -s /opt/julia-1.10.9/bin/julia /usr/local/bin/julia && \
    rm /tmp/julia.tar.gz

# NO CMD HERE! The entrypoint expects to find `hello-world.sh` or a shebang.
# The `hello-world.jl` file will use a shebang to find the julia executable.
COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]