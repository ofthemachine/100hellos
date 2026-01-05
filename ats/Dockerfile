# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

ENV PATSHOME=/usr/local/lib/ats2-postiats-0.4.2

ENV PATH=$PATSHOME/bin:$PATH

RUN sudo apk add --no-cache gcc ncurses-dev gmp-dev musl-dev && \
    wget -O /tmp/ats2-postiats.tgz https://sourceforge.net/projects/ats2-lang/files/ats2-lang/ats2-postiats-0.4.2/ATS2-Postiats-0.4.2.tgz/download && \
    tar -zxvf /tmp/ats2-postiats.tgz -C /tmp && \
    cd /tmp/ATS2-Postiats-int-0.4.2 && \
    ./configure && \
    make all && \
    sudo make install && \
    sudo rm -rf /tmp/*

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
