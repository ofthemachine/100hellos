#!/usr/bin/env sh

cd /hello-world
erl -compile hello_world.erl
erl -noshell -s hello_world main -s init stop
