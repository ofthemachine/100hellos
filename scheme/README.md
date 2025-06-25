# Scheme

Chibi Scheme is a very small library intended for use as an extension and scripting language in C programs. In addition to support for lightweight VM-based threads, each VM itself runs in an isolated heap allowing multiple VMs to run simultaneously in different OS threads.

## About Scheme

Scheme is one of the oldest and most influential functional programming languages, originally developed at MIT in the 1970s by Guy Steele and Gerald Sussman. It's a minimalist dialect of Lisp that emphasizes:

- **Lexical scoping**: Variables are bound in the environment where they're defined
- **First-class functions**: Functions can be stored in variables, passed as arguments, and returned from other functions
- **Tail call optimization**: Recursive calls in tail position don't consume additional stack space
- **Homoiconicity**: Code and data share the same structure (both are lists)

## Chibi Scheme Features

- **Minimal footprint**: Designed to be embedded in C applications
- **R7RS compliance**: Implements the latest Scheme standard
- **Thread-safe**: Multiple isolated VMs can run concurrently
- **UTF-8 support**: Full Unicode string handling
- **Pattern matching**: Advanced destructuring capabilities

## The Hello World Program

```scheme
#!/usr/bin/env chibi-scheme
(import (chibi))
(display "Hello World!")
(newline)
```

The program demonstrates several Scheme concepts:
- `(import (chibi))` - Loads the base Chibi module with essential functions
- `(display "Hello World!")` - Function call using prefix notation
- `(newline)` - Prints a newline character for proper output formatting

## Why Scheme Matters

Scheme's influence extends far beyond its direct usage:
- **Academic impact**: Used to teach fundamental programming concepts in courses like MIT's 6.001
- **Language research**: Many programming language innovations were first explored in Scheme
- **Practical applications**: Powers applications like GNU Guile, Racket, and embedded scripting systems

Scheme's philosophy of "programming should be simple" continues to inspire modern language design, emphasizing that powerful abstractions can emerge from minimal, well-designed primitives.