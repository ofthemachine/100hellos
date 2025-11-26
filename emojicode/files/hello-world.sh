#!/usr/bin/env sh

set -e

cd /hello-world
emojicodec -o hello-world -S /artifacts/emojicode/build hello-world.🍇 || exit 1
./hello-world
