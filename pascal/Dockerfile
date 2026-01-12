FROM 100hellos/050-c:local

COPY --chown=human:human ./artifacts /artifacts
RUN cd /artifacts && make install
ENV PATH=/home/human/.local/bin:$PATH
COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
