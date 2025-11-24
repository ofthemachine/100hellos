#!/usr/bin/env sh

set -e

cd /hello-world

# If fraglet exists, execute it directly; otherwise use default
if [ -s /FRAGLET ]; then
    bf /FRAGLET
else
    bf hello-world.bf
fi
