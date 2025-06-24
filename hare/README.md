# Hare

Hare is a **systems programming language** designed by [Drew DeVault](https://harelang.org).  It targets POSIX-like kernels and produces **statically linked, MUSL-compatible** ELF binaries by default—perfect for the Alpine-based images used in 100hellos.

## Why it's interesting

* **Simple toolchain:** The single `hare` driver wraps the compiler (`harec`), QBE backend, assembler, and linker.
* **Safety without GC:** Memory-safe idioms such as slices, option types, and bounds-checked arrays, yet no runtime garbage collector.
* **First-class cross-compilation:** `hare build -t aarch64` produces binaries for other architectures with zero extra flags.
* **Low-level pragmatism:** Familiar C-style syntax, but modern features like modules, defer statements, and algebraic data types.

## Hello World explained

```hare
use fmt;

export fn main() void = {
    fmt::println("Hello World!")!;
};
```

* `use fmt;` imports the **fmt** standard-library module for formatted I/O.
* `export fn main()` marks the entry point that will be visible to the linker.
* The trailing `!` after `println` propagates any I/O error (similar to Rust's `?`).
* `;` terminates the block with an explicit semicolon—a Hare quirk.

## Try it yourself (inside the container)

```bash
# Build a static binary
hare build -o hello hello-world.ha
./hello
```

Or iterate quickly:

```bash
hare run hello-world.ha
```

## Further exploration

* Official site & docs: <https://harelang.org>
* Community IRC: `#hare` on Libera.Chat
* Blog post "Cross-compiling Hare programs is easy" for multi-arch builds.