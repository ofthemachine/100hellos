#!/bin/sh

# If this file is present, this is the file that runs when you add the
# RUN=1 option.
#
# Otherwise, the default behavior is to run the first file in the
# directory that matches the pattern `hello-world.*``.

# Build it
# Run it

# Compile and run the Mercury program
cd /hello-world
mmc --make --no-verbose-make -w hello_world
./hello_world

