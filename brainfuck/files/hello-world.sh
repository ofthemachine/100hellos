#!/usr/bin/env sh

set -e

cd /hello-world

# Entrypoint has already injected fraglet into hello-world.bf when mounted; just run it.
exec bf hello-world.bf
