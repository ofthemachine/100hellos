#!/usr/bin/env sh
set -e
cd /hello-world
tbc hello-world.bf > hello-world.c
gcc hello-world.c -o hello-world 2>/dev/null
./hello-world