# Pony Fraglet Guide

## Language Version
Pony 0.x (latest release via ponyup)

## Execution Model
- Compiled language using `ponyc` compiler
- Code is compiled to a binary, then executed
- Actor-based concurrency model with reference capabilities

## Key Characteristics
- Statically typed with type inference
- Actor-based concurrency (no shared mutable state)
- Reference capabilities for memory safety (iso, trn, ref, val, box, tag)
- No null pointer exceptions
- No data races
- Garbage collected
- Case-sensitive
- Indentation-sensitive (2 spaces standard)
- Functions and actors are first-class

## Fragment Authoring
Write valid Pony code. Your fragment can define actors, classes, functions, and the `Main` actor. Your fragment will be compiled and executed.

## Available Packages
The Pony standard library is available. Common packages include:
- `builtin` - Core types (String, Array, etc.)
- `time` - Time operations
- `collections` - Collections (List, Map, Set, etc.)
- `net/http` - HTTP client and server
- `json` - JSON encoding/decoding
- `regex` - Regular expressions
- `files` - File I/O

## Common Patterns
- Print: `env.out.print("message")` or `env.out.print("format: " + value.string())`
- Variables: `var x: I32 = 10` or `let x = 10` (type inference)
- Actors: `actor MyActor\n  new create() => ...`
- Classes: `class MyClass\n  var _field: String\n  new create(field: String) => _field = field`
- Functions: `fun add(a: I32, b: I32): I32 => a + b`
- Arrays: `let arr = [1; 2; 3]` or `let arr = Array[I32]`
- Strings: `let s = "Hello" + " " + "World"`
- Reference capabilities: `iso`, `trn`, `ref`, `val`, `box`, `tag`
- Pattern matching: `match x\n| 1 => ...\n| 2 => ...\nelse => ...\nend`

## Examples
```pony
// Simple output
actor Main
  new create(env: Env) =>
    env.out.print("Hello from fragment!")

// Variables and calculations
actor Main
  new create(env: Env) =>
    let a: I32 = 5
    let b: I32 = 10
    env.out.print("Sum: " + (a + b).string())

// Functions
actor Main
  new create(env: Env) =>
    env.out.print("5 + 10 = " + add(5, 10).string())

  fun add(a: I32, b: I32): I32 =>
    a + b

// Arrays and loops
actor Main
  new create(env: Env) =>
    let numbers: Array[I32] = [1; 2; 3; 4; 5]
    var sum: I32 = 0
    for num in numbers.values() do
      sum = sum + num
    end
    env.out.print("Sum: " + sum.string())

// Classes
class Person
  var _name: String
  var _age: I32

  new create(name: String, age: I32) =>
    _name = name
    _age = age

  fun string(): String =>
    _name + " is " + _age.string() + " years old"

actor Main
  new create(env: Env) =>
    let p = Person("Alice", 30)
    env.out.print(p.string())

// String operations
actor Main
  new create(env: Env) =>
    let s = "Hello"
    env.out.print(s + " World!")
    env.out.print("Length: " + (s + " World!").size().string())

// Pattern matching
actor Main
  new create(env: Env) =>
    let x: I32 = 2
    match x
    | 1 => env.out.print("One")
    | 2 => env.out.print("Two")
    else
      env.out.print("Other")
    end
```

## Caveats
- Fragments must be valid Pony code that compiles
- Reference capabilities are important for memory safety - understand `iso`, `trn`, `ref`, `val`, `box`, `tag`
- Variables declared with `var` are mutable, `let` are immutable
- Arrays are reference types - use reference capabilities to control sharing
- The code is compiled fresh each time, so compilation errors will fail execution
- Pony uses structural typing for some types (e.g., numeric types)
- Actor constructors must be named `create` and take `env: Env` for Main actor
- String concatenation uses `+` operator
- Type inference works for local variables but may need explicit types for function parameters/returns
