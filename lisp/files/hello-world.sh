#!/usr/bin/env sh

# sbcl --non-interactive --load /hello-world/hello-world.el
sbcl --noinform --no-sysinit --no-userinit --script /hello-world/hello-world.el