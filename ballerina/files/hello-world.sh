#!/usr/bin/env bash

cd /hello-world
source /home/human/.sdkman/bin/sdkman-init.sh
ballerina build hello-world.bal >/dev/null
ballerina run hello-world.jar "$@"