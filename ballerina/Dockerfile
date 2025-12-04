# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/080-java8:local

RUN bash -c "source /home/human/.sdkman/bin/sdkman-init.sh && sdk install ballerina"

COPY --chown=human:human ./files /hello-world
