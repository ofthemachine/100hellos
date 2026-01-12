#!/usr/bin/env sh

cd /hello-world
iverilog -o hello-world hello-world.v
./hello-world | grep -v \$finish
