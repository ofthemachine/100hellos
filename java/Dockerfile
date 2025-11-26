# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/100-java11:local

# Copy wordalytica source and compile to JAR
COPY --chown=human:human ./wordalytica /tmp/wordalytica
RUN cd /tmp/wordalytica && \
    mkdir -p classes && \
    find com -name "*.java" ! -name "Benchmarker.java" > sources.txt && \
    javac -d classes @sources.txt && \
    jar cf /tmp/wordalytica.jar -C classes . && \
    sudo mkdir -p /lib && \
    sudo mv /tmp/wordalytica.jar /lib/wordalytica.jar && \
    sudo cp words.all /lib/words.all && \
    sudo chown -R human:human /lib && \
    rm -rf /tmp/wordalytica

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

# ENTRYPOINT inherited from 100-java11 (fraglet-entrypoint)
