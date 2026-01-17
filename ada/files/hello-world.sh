#!/usr/bin/env sh

cd /hello-world
gnatmake -q hello.adb
./hello "$@"
