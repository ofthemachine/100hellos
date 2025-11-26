#!/usr/bin/env sh

set -e

cd /hello-world
javac -cp /lib/wordalytica.jar:. HelloWorld.java || exit 1
java -cp /lib/wordalytica.jar:. HelloWorld
