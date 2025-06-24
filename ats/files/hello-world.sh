#!/usr/bin/env sh

# If this file is present, this is the file that runs when you add the
# RUN=1 option.
#
# Otherwise, the default behavior is to run the first file in the
# directory that matches the pattern `hello-world.*``.

# Build it
# Run it

patscc -o hello_world /hello-world/hello-world.dats
./hello_world

