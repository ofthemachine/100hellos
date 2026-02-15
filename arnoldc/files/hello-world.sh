#!/usr/bin/env sh

cd /hello-world
java -jar /usr/local/bin/ArnoldC.jar hello-world.arnoldc
java hello-world "$@"
