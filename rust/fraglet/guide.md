# Rust Fraglet Guide

## Language Version
Rust (latest stable from Alpine package repository)

## Execution Model
- Compiled language using `rustc`
- Code is compiled to a binary, then executed
- Standard Rust execution model with `main()` function

## Key Characteristics
- Statically typed with type inference
- Memory-safe without garbage collection (ownership system)
- Zero-cost abstractions
- Pattern matching
- Traits for polymorphism
- Enums with data (sum types)
- Immutable by default (mutability is explicit)
- Case-sensitive
- Expression-based (most things are expressions, not statements)

## Fragment Authoring
Write valid Rust code. Your fragment can define functions, structs, enums, traits, and the `main()` function. The standard library is available. Your fragment will be compiled and executed.

## Available Libraries
The template includes the standard library (std), which provides:
- `println!` and `print!` macros for output
- `format!` macro for string formatting
- Collections: `Vec`, `HashMap`, `HashSet`
- String manipulation
- File I/O
- Networking
- Concurrency primitives
- And much more from the Rust standard library

## Common Patterns
- Print: `println!("message")` or `println!("format {}", value)`
- Variables: `let x = 10;` or `let mut x = 10;` (mutable)
- Functions: `fn add(a: i32, b: i32) -> i32 { a + b }`
- Structs: `struct Person { name: String, age: u32 }`
- Methods: `impl Person { fn new(name: String, age: u32) -> Self { ... } }`
- Vectors: `let v = vec![1, 2, 3];` or `let mut v = Vec::new();`
- HashMaps: `let mut m = HashMap::new();` or `let m = HashMap::from([("key", "value")]);`
- Pattern matching: `match value { Some(x) => ..., None => ... }`
- Option: `Some(value)` or `None`
- Result: `Ok(value)` or `Err(error)`
- Iterators: `vec.iter()`, `vec.iter_mut()`, `vec.into_iter()`

## Examples
```rust
// Simple output
fn main() {
    println!("Hello from fragment!");
}

// Variables and calculations
fn main() {
    let a = 5;
    let b = 10;
    println!("Sum: {}", a + b);
}

// Functions
fn add(a: i32, b: i32) -> i32 {
    a + b
}

fn main() {
    let result = add(5, 10);
    println!("5 + 10 = {}", result);
}

// Vectors and loops
fn main() {
    let numbers = vec![1, 2, 3, 4, 5];
    let sum: i32 = numbers.iter().sum();
    println!("Sum: {}", sum);
}

// Structs and methods
struct Person {
    name: String,
    age: u32,
}

impl Person {
    fn new(name: String, age: u32) -> Self {
        Person { name, age }
    }
    
    fn greet(&self) {
        println!("{} is {} years old", self.name, self.age);
    }
}

fn main() {
    let p = Person::new("Alice".to_string(), 30);
    p.greet();
}

// HashMaps
use std::collections::HashMap;

fn main() {
    let mut m = HashMap::new();
    m.insert("apple", 5);
    m.insert("banana", 3);
    println!("Apples: {}", m["apple"]);
}

// String operations
fn main() {
    let mut s = String::from("Hello");
    s.push_str(" World!");
    println!("{}", s);
    println!("Length: {}", s.len());
}

// Pattern matching with Option
fn main() {
    let maybe_value = Some(42);
    match maybe_value {
        Some(x) => println!("Value: {}", x),
        None => println!("No value"),
    }
}

// Iterators
fn main() {
    let numbers = vec![1, 2, 3, 4, 5];
    let doubled: Vec<i32> = numbers.iter().map(|x| x * 2).collect();
    println!("Doubled: {:?}", doubled);
}
```

## Caveats
- Fragments must be valid Rust code that compiles
- Variables are immutable by default - use `let mut` for mutable variables
- Ownership rules apply - you cannot have multiple mutable references to the same data
- String literals are `&str`, owned strings are `String`
- Use `.to_string()` or `String::from()` to convert `&str` to `String`
- The code is compiled fresh each time, so compilation errors will fail execution
- Rust requires explicit error handling - functions that return `Result` should handle errors
- References must be explicitly borrowed with `&` or `&mut`
- Lifetime annotations may be needed for complex code, but simple fragments usually don't need them
- Use `println!("{:?}", value)` to print debug representation of types that implement `Debug`
