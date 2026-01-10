# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install Chapel dependencies for Alpine 3.18 as per official documentation
# https://chapel-lang.org/docs/usingchapel/prereqs.html
RUN sudo apk add --no-cache \
    gcc g++ m4 perl python3 python3-dev bash make gawk git cmake \
    llvm15-dev clang15-dev llvm15-static clang15-static

# Download and build Chapel from source
# Using version 2.5.0 (latest stable)
RUN cd /tmp && \
    sudo wget https://github.com/chapel-lang/chapel/releases/download/2.5.0/chapel-2.5.0.tar.gz && \
    sudo tar xzf chapel-2.5.0.tar.gz && \
    sudo chown -R human:human chapel-2.5.0

# Build Chapel with system LLVM
USER human
WORKDIR /tmp/chapel-2.5.0
ENV CHPL_HOME=/tmp/chapel-2.5.0
ENV CHPL_LLVM=system
ENV CHPL_TARGET_COMPILER=llvm
RUN make -j$(nproc)

# Add Chapel binary to PATH and verify it works
ENV PATH="/tmp/chapel-2.5.0/bin/linux64-x86_64:$PATH"
RUN chpl --version

# Clean up source tarball but keep built Chapel (as root to avoid permission issues)
USER root
RUN rm -f /tmp/chapel-2.5.0.tar.gz

USER human
WORKDIR /hello-world

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
