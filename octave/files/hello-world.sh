#!/usr/bin/env sh

# Run octave script, suppressing X11/GUI warnings
octave --no-gui --quiet /hello-world/hello-world.m 2>/dev/null

