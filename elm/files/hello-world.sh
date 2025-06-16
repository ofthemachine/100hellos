#!/bin/sh

# Elm needs to be in a project directory
cd /hello-world

# Initialize an elm project, accepting defaults
yes | elm init > /dev/null 2>&1

# Compile the elm file
elm make --output=/tmp/hello.html src/Main.elm > /dev/null 2>&1

# The html file is complex, so we'll just find the string we need for the test
grep -o "Hello World!" /tmp/hello.html

