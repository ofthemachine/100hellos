#!/usr/bin/env sh

set -e

cd /hello-world
gcc -Wall -Wextra -o hello hello-world.c || exit 1
./hello "$@"
