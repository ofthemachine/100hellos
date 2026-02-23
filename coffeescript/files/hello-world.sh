#!/usr/bin/env sh

cd /hello-world
coffee --compile hello-world.coffee
exec node hello-world.js "$@"

