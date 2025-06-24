#!/usr/bin/env sh
# Compile and run the Hare "Hello World!" program.
set -eu

# Build a static binary and execute it
hare build -o /tmp/hello hello-world.ha
/tmp/hello

