#!/usr/bin/env sh

# If this file is present, this is the file that runs when you add the
# RUN=1 option.
#
# Otherwise, the default behavior is to run the first file in the
# directory that matches the pattern `hello-world.*``.

# Build it
# Run it

# Compile and run the Standard ML program using Poly/ML, suppressing startup messages
poly --quiet < /hello-world/hello-world.sml 2>/dev/null

