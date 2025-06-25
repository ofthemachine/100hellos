# Idris2

Idris2 is a purely functional programming language with dependent types, designed to be a practical programming language for type-driven development. It represents the evolution of the original Idris language with improved performance, better error messages, and enhanced tooling.

## Language Features

**Dependent Types**: Idris2's type system allows types to depend on values, enabling incredibly precise type specifications that can encode program invariants directly in the type system.

**Type-Driven Development**: The language encourages a development style where you start with types that express what your program should do, then implement the functions that satisfy those types.

**Total Functions**: Idris2 can verify that functions are total (always terminate and handle all possible inputs), providing strong guarantees about program behavior.

**Linear Types**: Idris2 includes support for linear types, which can express resource usage patterns and prevent common errors like use-after-free or double-free.

## Hello World Explanation

```idris
module Main

main : IO ()
main = putStrLn "Hello World!"
```

- `module Main` declares this as the main module
- `main : IO ()` specifies that `main` has type `IO ()`, meaning it performs I/O actions and returns the unit type
- `putStrLn` is the standard function for printing a line to stdout
- The `IO` type ensures that side effects are tracked in the type system

## Interesting Facts

- **Academic Origins**: Idris was developed by Edwin Brady at the University of St Andrews, with Idris2 being a complete rewrite for better performance
- **Proof Assistant**: While primarily a programming language, Idris2 can also function as a proof assistant due to the Curry-Howard correspondence
- **Elaborator Reflection**: Idris2 provides powerful metaprogramming capabilities through elaborator reflection, allowing you to write programs that generate other programs
- **Multiple Backends**: Idris2 can compile to multiple targets including Scheme (Chez Scheme), JavaScript, and RefC (a custom C backend)

## Type-Driven Development Example

In Idris2, you might define a vector type that encodes its length in the type:

```idris
data Vect : Nat -> Type -> Type where
  Nil  : Vect Z a
  (::) : a -> Vect k a -> Vect (S k) a
```

This allows the type system to prevent index-out-of-bounds errors at compile time!

## Further Exploration

- Try the [Idris2 tutorial](https://idris2.readthedocs.io/en/latest/tutorial/index.html) to learn type-driven development
- Explore dependent types with the classic "vectors indexed by length" example
- Read "Type-Driven Development with Idris" by Edwin Brady for comprehensive coverage
- Check out the [Idris2 documentation](https://idris2.readthedocs.io/) for advanced features

Idris2 represents the cutting edge of practical dependently-typed programming, making advanced type theory concepts accessible for everyday programming tasks.