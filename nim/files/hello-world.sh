#!/bin/sh

# If this file is present, this is the file that runs when you add the
# RUN=1 option.
#
# Otherwise, the default behavior is to run the first file in the
# directory that matches the pattern `hello-world.*``.

# Build it
# Run it

nim c -o:/tmp/hello /hello-world/helloworld.nim
/tmp/hello

