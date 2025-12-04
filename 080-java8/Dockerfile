FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    bash zip openjdk8

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

# Install sdkman (required by ballerina and ceylon)
RUN curl -s "https://get.sdkman.io" | bash

