# Gleam Fraglet Guide

## Language Version
Gleam (latest available in Alpine)

## Execution Model
- Compiled, then executed via Erlang/BEAM VM
- Execution via `gleam run` (requires project structure)

## Key Characteristics
- Functional programming language
- Type-safe with compile-time type checking
- Immutable data structures
- Pattern matching
- No null values - uses `Result` and `Option` types
- Case-sensitive
- Pipe operator `|>` for data transformations
- Functions are first-class citizens
- Variables start with lowercase: `x`, `name`
- Types start with uppercase: `Int`, `String`, `Result`

## Fragment Authoring
Write valid Gleam code. Your fragment can define functions, import modules, and write complete module code. You can:

- Define multiple functions
- Use pattern matching
- Write complete function implementations
- Use the pipe operator
- Work with Result and Option types

**Important**: The execution script calls `main()`, so your fragment must define `pub fn main()` for the code to execute. You can define additional helper functions as needed.

## Available Libraries
Standard Gleam library (`gleam/io`, `gleam/result`, `gleam/option`, etc.) is available. The `gleam_stdlib` package is included in the project.

## Common Patterns
- Print: `io.println("message")`
- String concatenation: `"Hello, " <> name`
- Pattern matching: `case x { 1 -> "one" }`
- Pipe operator: `list |> list.map(fn(x) { x * 2 })`
- Result handling: `case result { Ok(value) -> ... Error(e) -> ... }`
- Option handling: `case option { Some(value) -> ... None -> ... }`
- Function definitions: `pub fn greet(name) { ... }`
- Anonymous functions: `fn(x) { x * 2 }`
- List operations: `list.map(fn(x) { x * 2 })`, `list.filter(...)`, `list.length(...)`

## Examples

```gleam
// Simple output
pub fn main() {
  io.println("Hello, World!")
}
```

```gleam
// Function with parameters
pub fn main() {
  greet("Alice")
}

fn greet(name: String) {
  io.println("Hello, " <> name <> "!")
}
```

```gleam
// Pattern matching with custom type
import gleam/int

pub type Op {
  Add
  Multiply
}

pub fn main() {
  let result = calculate(Add, 5, 10)
  io.println("Result: " <> int.to_string(result))
}

fn calculate(op: Op, a: Int, b: Int) -> Int {
  case op {
    Add -> a + b
    Multiply -> a * b
  }
}
```

```gleam
// List processing with pipe operator
import gleam/list
import gleam/int
pub fn main() {
  let numbers = [1, 2, 3, 4, 5]
  let sum = numbers
    |> list.map(fn(x) { x * x })
    |> list.fold(0, fn(acc, x) { acc + x })
  io.println("Sum of squares: " <> int.to_string(sum))
}
```

```gleam
// Recursion
import gleam/int
pub fn main() {
  let result = factorial(5)
  io.println("Factorial of 5: " <> int.to_string(result))
}

fn factorial(n: Int) -> Int {
  case n {
    0 -> 1
    n -> n * factorial(n - 1)
  }
}
```

```gleam
// Multiple functions
import gleam/int
pub fn main() {
  io.println("Double 5: " <> int.to_string(double(5)))
  io.println("Triple 5: " <> int.to_string(triple(5)))
}

fn double(x: Int) -> Int {
  x * 2
}

fn triple(x: Int) -> Int {
  x * 3
}
```

```gleam
// Using Result type
import gleam/result
import gleam/int
pub fn main() {
  case divide(10, 2) {
    Ok(value) -> io.println("Result: " <> int.to_string(value))
    Error(_) -> io.println("Division by zero!")
  }
}

fn divide(a: Int, b: Int) -> Result(Int, String) {
  case b {
    0 -> Error("Cannot divide by zero")
    _ -> Ok(a / b)
  }
}
```

```gleam
// List comprehensions and filtering
pub fn main() {
  let numbers = [1, 2, 3, 4, 5, 6]
  let evens = list.filter(numbers, fn(x) { x % 2 == 0 })
  io.println("Even numbers: " <> debug.to_string(evens))
}
```

## Caveats
- Module name must match filename (without extension)
- Functions must be `pub fn` to be callable from command line
- Gleam uses `<>` for string concatenation
- Variables are immutable (single-assignment)
- Pattern matching is exhaustive - all cases must be covered
- Type annotations are optional but recommended for clarity
- The main function must be `pub fn main()` and return `Nil`
- Gleam requires a project structure (gleam.toml) to compile
- Import statements must be at the top of the file (outside the injection range)
