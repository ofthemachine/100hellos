#!/usr/bin/env sh

set -e

cd /hello-world
g++ -o hello hello-world.cpp || exit 1
./hello "$@"
