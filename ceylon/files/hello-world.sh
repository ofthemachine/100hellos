#!/usr/bin/env sh

cd /hello-world
compile_out=$(ceylon compile hello 2>&1) || { echo "$compile_out" >&2; exit 1; }
echo "$compile_out" | grep -v '^Note: Created module ' >&2
[ "$1" = "--" ] && shift
ceylon run hello/1.0.0 -- "$@"