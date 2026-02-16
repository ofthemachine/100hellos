#!/usr/bin/env sh

cd /hello-world
zig run hello-world.zig -- "$@"
