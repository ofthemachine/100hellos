# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/080-java8:local

RUN bash -c "source /home/human/.sdkman/bin/sdkman-init.sh && sdk install ant"

COPY --chown=human:human ./artifacts /artifacts
ENV PATH="/home/human/.sdkman/candidates/ant/current/bin:${PATH}"
RUN cd /artifacts && make install
ENV PATH="/home/human/.ceylon/bin:${PATH}"

COPY --chown=human:human ./files /hello-world
