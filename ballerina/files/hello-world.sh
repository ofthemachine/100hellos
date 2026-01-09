#!/usr/bin/env bash

cd /hello-world
source /home/human/.sdkman/bin/sdkman-init.sh
ballerina build hello-world.bal
ballerina run hello-world.jar