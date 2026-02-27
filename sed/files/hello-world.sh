#!/usr/bin/env sh

cd /hello-world
chmod +x hello-world.sed
{ cat; echo; } | ./hello-world.sed "$@"