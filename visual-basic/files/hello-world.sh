#!/usr/bin/env sh

set -e

export DOTNET_NOLOGO=1
cd /hello-world
dotnet run -- "$@"
