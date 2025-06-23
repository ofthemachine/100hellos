# Nix

Nix is a purely functional package manager and build system that treats packages like values in purely functional programming languages such as Haskell - they are built by functions that don't have side-effects, and they never change after they have been built.

## Language Overview

Nix is both a package manager and a domain-specific functional programming language used for package management and system configuration. The Nix language is dynamically typed and purely functional, making it excellent for describing package builds and system configurations in a declarative way.

## Hello World Explanation

Our Nix "Hello World!" program uses a pure Nix expression that gets evaluated natively:

**hello-world.nix:**
```nix
# Pure Nix Hello World program
# This is a native Nix expression that evaluates to "Hello World!"
"Hello World!"
```

**hello-world.sh:**
```bash
#!/bin/sh
# Source Nix environment
. /home/human/.nix-profile/etc/profile.d/nix.sh

# Evaluate the pure Nix expression and clean up the output
nix-instantiate --eval --strict /hello-world/hello-world.nix | tr -d '"'
```

This approach demonstrates Nix's core functionality as a language - we write a pure Nix expression (just the string literal `"Hello World!"`) and use `nix-instantiate --eval` to evaluate it. This is truly native Nix, not just using Nix to spawn other tools.

## Unique Features

- **Purely Functional**: Package definitions are written as functions with no side effects
- **Reproducible Builds**: Identical inputs always produce identical outputs
- **Atomic Upgrades and Rollbacks**: System changes are atomic and can be rolled back
- **Multiple Versions**: Different versions of packages can coexist without conflicts
- **Lazy Evaluation**: Expressions are only evaluated when needed
- **Immutable Store**: Packages are stored in an immutable way using cryptographic hashes

## MUSL Compatibility

Nix works excellently on MUSL-based systems like Alpine Linux through its single-user installation mode. The `--no-daemon` flag ensures compatibility with containerized environments and MUSL-based distributions.

## Beyond Hello World

You can easily modify the `hello-world.nix` file to explore more complex Nix capabilities:

### Complex Nix Expressions
```nix
# Mathematical expression
1 + 2 * 3

# String interpolation
let name = "World"; in "Hello ${name}!"

# Function application
(x: "Hello " + x) "World!"

# List operations
builtins.head ["Hello" "World" "!"]
```

### Using Nix for Package Management
You can also modify the shell script to use `nix-shell` for creating reproducible environments:

```bash
#!/usr/bin/env nix-shell
#!nix-shell -i bash -p figlet cowsay

figlet "Hello from Nix!"
cowsay "Reproducible environments are awesome!"
```

### Pure Nix Expression Evaluation
The beauty of this approach is that `hello-world.nix` contains pure Nix language code that can be arbitrarily complex, while the shell script simply evaluates it using native Nix tools.

## Further Exploration

- Try the [Nix Pills](https://nixos.org/guides/nix-pills/) tutorial series
- Explore [NixOS](https://nixos.org/) - a Linux distribution built around Nix
- Learn about [Flakes](https://nixos.wiki/wiki/Flakes) - Nix's modern package management system
- Experiment with more complex Nix expressions in the `.nix` file