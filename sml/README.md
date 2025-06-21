# Standard ML (SML) - Hello World!

Standard ML (SML) is a general-purpose, modular, functional programming language with compile-time type checking and type inference. Developed in the 1980s, it's known for its mathematical foundations and elegant design.

## About Standard ML

Standard ML was designed as a meta-language for the Edinburgh LCF theorem prover, but evolved into a standalone programming language. It features:

- **Strong static typing** with Hindley-Milner type inference
- **Functional programming** with immutable data structures by default
- **Pattern matching** for elegant control flow
- **Module system** for large-scale program organization
- **Formal semantics** - one of the few languages with a complete formal definition

## This Implementation

This container uses **Poly/ML**, a full implementation of Standard ML that's particularly well-suited for interactive development and deployment. Poly/ML is compatible with musl libc, making it perfect for Alpine Linux containers.

## Fun Facts

- Standard ML has influenced many modern languages including OCaml, Haskell, and Rust
- It was one of the first languages to feature garbage collection and polymorphic type inference
- The language definition fits in a relatively small book, yet it's computationally complete
- Robin Milner, one of SML's creators, won the Turing Award partly for his work on type systems

## Language Features Showcase

```sml
(* This simple "Hello World!" demonstrates SML's clean syntax *)
print "Hello World!\n";

(* But SML can do much more with functions and pattern matching *)
fun factorial 0 = 1
  | factorial n = n * factorial (n - 1);

(* Polymorphic data structures *)
datatype 'a option = NONE | SOME of 'a;
```

SML proves that functional programming can be both mathematically rigorous and practically useful!