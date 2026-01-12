#!/usr/bin/env bash
source /home/human/.sdkman/bin/sdkman-init.sh
cd /hello-world
kotlinc hello-world.kt -include-runtime -d hello.jar
java -jar hello.jar