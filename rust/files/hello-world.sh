#!/usr/bin/env sh

cd /hello-world
rustc hello-world.rs
./hello-world "$@"
