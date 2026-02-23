#!/usr/bin/env sh

set -e
cd /hello-world
cobc -free -x hello-world.cob
exec ./hello-world "$@"

