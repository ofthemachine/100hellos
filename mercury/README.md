# Mercury

Mercury is a pure logic programming language that combines the power of Prolog with static typing and functional programming features. It was designed at the University of Melbourne for building large, reliable, and efficient applications.

## About Mercury

Mercury is known for its:

- **Strong static typing**: Type errors are caught at compile time
- **Mode system**: Ensures variables are used correctly
- **Determinism system**: Specifies whether predicates succeed, fail, or produce multiple solutions
- **Functional and logic programming**: Supports both paradigms seamlessly
- **High performance**: Compiles to efficient C code

## Features

Mercury combines the expressiveness of logic programming with the safety of strong typing. The language uses a sophisticated type, mode, and determinism system to ensure program correctness at compile time.

The Mercury compiler generates efficient C code and provides excellent error messages, making it suitable for large-scale software development.

## Hello World Explained

```mercury
:- module hello_world.

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
main(!IO) :-
    io.write_string("Hello World!", !IO).
```

- `:- module hello_world.` - Declares the module name
- `:- interface.` - Begins the public interface section
- `:- import_module io.` - Imports the I/O module
- `:- pred main(io::di, io::uo) is det.` - Declares main as a deterministic predicate
- `main(!IO) :-` - Uses state variables for I/O threading
- `io.write_string("Hello World!", !IO)` - Outputs the string

## Learn More

- [Mercury Language Website](https://mercurylang.org/)
- [Mercury Tutorial](https://mercurylang.org/information/doc-release/mercury_user_guide.html)
- [Language Reference](https://mercurylang.org/information/doc-release/mercury_ref.html)