#!/usr/bin/env sh

cd /hello-world
ocamlc -w -24 hello-world.ml -o hello-world
./hello-world "$@"

