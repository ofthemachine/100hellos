#!/usr/bin/env sh

# Compile the Pony source (ponyc expects a directory path)
ponyc /hello-world -o /tmp/

# Run the compiled binary
/tmp/hello-world

