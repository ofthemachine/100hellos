#!/bin/sh
# Compile the Odin source file
odin build /hello-world/hello-world.odin -file -out:/tmp/hello
# Execute the compiled binary
/tmp/hello

