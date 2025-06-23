#!/bin/sh

# Source Nix environment
. /home/human/.nix-profile/etc/profile.d/nix.sh

# Evaluate the pure Nix expression and clean up the output
nix-instantiate --eval --strict /hello-world/hello-world.nix | tr -d '"'