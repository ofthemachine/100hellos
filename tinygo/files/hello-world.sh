#!/bin/sh
cd /hello-world
# Compile TinyGo code to a binary
tinygo build -o /tmp/hello-world hello-world.go
# Run the compiled binary
/tmp/hello-world

