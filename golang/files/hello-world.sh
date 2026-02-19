#!/usr/bin/env sh

cd /hello-world
go build -o hello hello-world.go
./hello "$@"
