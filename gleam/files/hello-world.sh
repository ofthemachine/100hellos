#!/usr/bin/env sh

# If this file is present, this is the file that runs when you add the
# RUN=1 option.
#
# Otherwise, the default behavior is to run the first file in the
# directory that matches the pattern `hello-world.*``.

# Compile and run the Gleam program
# Note: Gleam requires a project structure, so we'll initialize a minimal project

# Create a minimal gleam.toml file
cat > /hello-world/gleam.toml << EOF
name = "hello_world"
version = "1.0.0"

[dependencies]
gleam_stdlib = ">= 0.34.0 and < 2.0.0"
EOF

# Create the src directory and move our source file
mkdir -p /hello-world/src
cp /hello-world/hello-world.gleam /hello-world/src/hello_world.gleam

# Build the project and run it
cd /hello-world
gleam run --no-print-progress

