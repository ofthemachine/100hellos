# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install build dependencies and CSNOBOL4
RUN sudo \
  apk add --no-cache \
    build-base \
    wget \
    tar \
    make \
    gcc \
    libc-dev \
    m4

# Download and compile CSNOBOL4 (snobol4-2.3.3.tar.gz from FTP)
RUN cd /tmp && \
    wget -O snobol4-2.3.3.tar.gz "ftp://ftp.regressive.org/snobol4/snobol4-2.3.3.tar.gz" && \
    tar -xzf snobol4-2.3.3.tar.gz && \
    cd snobol4-2.3.3 && \
    ./configure --prefix=/usr/local && \
    make && \
    sudo make install && \
    cd / && \
    rm -rf /tmp/snobol4-*

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
