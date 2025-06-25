#!/usr/bin/env sh

# If this file is present, this is the file that runs when you add the
# RUN=1 option.
#
# Otherwise, the default behavior is to run the first file in the
# directory that matches the pattern `hello-world.*``.

# Compile the Idris2 program
idris2 --output-dir /tmp/build -o hello /hello-world/hello-world.idr

# Run it
/tmp/build/hello

