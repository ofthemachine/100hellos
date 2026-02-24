#!/usr/bin/env sh

cd /hello-world
java -cp $OBERON_BIN oberonc . hello-world.mod
java -cp $OBERON_BIN:. Fraglet "$@"
