#!/usr/bin/env sh

cd /hello-world
gnatmake -q fraglet.adb
./fraglet "$@"
