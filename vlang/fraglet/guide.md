# V Fraglet Guide

## Language Version
V (latest from Alpine edge repositories)

## Execution Model
- Compiled language
- Code is compiled to a binary, then executed
- Standard V execution model with `main()` function

## Key Characteristics
- Statically typed with type inference
- Case-sensitive
- Garbage collected
- Similar syntax to Go but with some differences
- No null values (uses Option types)
- Immutable by default (use `mut` for mutable variables)
- Functions are first-class citizens
- Module-based organization
- Built-in concurrency support
- Fast compilation

## Fragment Authoring
Write valid V code. Your fragment can define functions, types, and the `main()` function. Your fragment will be compiled and executed.

## Available Libraries
The standard library includes:
- `println()` - Print with newline
- `print()` - Print without newline
- `eprintln()` - Print to stderr with newline

Additional standard library modules can be imported as needed:
- `os` - Operating system interface
- `strings` - String manipulation
- `math` - Mathematical functions
- `time` - Time operations
- `json` - JSON encoding/decoding
- `http` - HTTP client and server
- And many more from the V standard library

## Common Patterns
- Print: `println('message')` or `println('format ${value}')`
- Variables: `x := 10` (type inference) or `x int = 10` (explicit type)
- Mutable variables: `mut x := 10` then `x = 20`
- Functions: `fn add(a int, b int) int { return a + b }`
- Structs: `struct Person { name string age int }`
- Methods: `fn (p Person) greet() { println('Hello, ${p.name}') }`
- Arrays: `numbers := [1, 2, 3]` or `numbers := []int{cap: 10}`
- Maps: `m := map[string]int{}` or `m := {'a': 1, 'b': 2}`
- String interpolation: `'Hello, ${name}!'`
- Option types: `x ?int` (can be `none` or `some(value)`)
- Error handling: `result := fn_that_may_fail() or { return }`

## Examples
```v
// Simple output
fn main() {
    println('Hello from fragment!')
}

// Variables and calculations
fn main() {
    a := 5
    b := 10
    println('Sum: ${a + b}')
}

// Functions
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(5, 10)
    println('5 + 10 = ${result}')
}

// Arrays and loops
fn main() {
    numbers := [1, 2, 3, 4, 5]
    mut sum := 0
    for num in numbers {
        sum += num
    }
    println('Sum: ${sum}')
}

// Structs and methods
struct Person {
    name string
    age  int
}

fn (p Person) greet() {
    println('${p.name} is ${p.age} years old')
}

fn main() {
    p := Person{name: 'Alice', age: 30}
    p.greet()
}

// Maps
fn main() {
    mut m := map[string]int{}
    m['apple'] = 5
    m['banana'] = 3
    println('Apples: ${m['apple']}')
}

// String operations
fn main() {
    mut s := 'Hello'
    s += ' World!'
    println(s)
    println('Length: ${s.len}')
}

// Mutable variables
fn main() {
    mut x := 10
    x = 20
    println('x = ${x}')
}
```

## Caveats
- Fragments must be valid V code that compiles
- Variables are immutable by default - use `mut` keyword for mutable variables
- V has no null values - use Option types (`?int`, `?string`, etc.) instead
- String interpolation uses `${expression}` syntax
- Arrays are zero-indexed
- The code is compiled fresh each time, so compilation errors will fail execution
- Type inference is powerful but explicit types can be clearer
- Functions must have explicit return types
- Struct fields are private by default (lowercase) - use uppercase for public fields
- V is still evolving, so some features may change
