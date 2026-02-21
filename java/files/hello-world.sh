#!/usr/bin/env sh

set -e

cd /hello-world
javac -cp /lib/wordalytica.jar:. Fraglet.java || exit 1
java -cp /lib/wordalytica.jar:. Fraglet "$@"
