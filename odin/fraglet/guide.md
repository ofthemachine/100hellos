# Odin Fraglet Guide

## Language Version
Odin (latest from source, built with LLVM)

## Execution Model
- Compiled language using `odin build`
- Code is compiled to a binary, then executed
- Standard Odin execution model with `main :: proc()` procedure in `main` package

## Key Characteristics
- Statically typed with type inference
- Case-sensitive
- Explicit memory management (no garbage collection by default)
- Procedure-based (functions are called "procedures")
- Package-based module system
- Built-in support for arrays, slices, and dynamic arrays
- Strong C interop capabilities
- Data-oriented design principles
- Zero hidden allocations

## Fragment Authoring
Write valid Odin code. Your fragment can define procedures, types, and the `main :: proc()` procedure. Package and import declarations are already in place. Your fragment will be compiled and executed.

## Available Packages
The template includes the standard library package:
- `core:fmt` - Formatted I/O (println, printf, printfln)

Additional standard library packages can be imported as needed:
- `core:strings` - String manipulation
- `core:strconv` - String conversions
- `core:os` - Operating system interface
- `core:io` - I/O primitives
- `core:math` - Mathematical functions
- `core:time` - Time operations
- `core:mem` - Memory management
- `core:slice` - Slice operations
- `core:sort` - Sorting algorithms
- And many more from the Odin standard library

## Common Patterns
- Print: `fmt.println("message")` or `fmt.printf("format %s\n", value)`
- Variables: `x: int = 10` or `x := 10` (type inference)
- Procedures: `add :: proc(a, b: int) -> int { return a + b }`
- Structs: `Person :: struct { name: string; age: int }`
- Arrays: `numbers: [5]int = {1, 2, 3, 4, 5}`
- Slices: `numbers := []int{1, 2, 3}` or `numbers := make([]int, 0, 10)`
- Dynamic arrays: `numbers: [dynamic]int`
- Maps: `m := make(map[string]int)` or `m: map[string]int = {"a" = 1}`
- For loops: `for i in 0..<len(arr) { ... }` or `for value in arr { ... }`
- If statements: `if condition { ... } else { ... }`

## Examples
```odin
// Simple output
main :: proc() {
    fmt.println("Hello from fragment!")
}

// Variables and calculations
main :: proc() {
    a: int = 5
    b: int = 10
    fmt.printf("Sum: %d\n", a + b)
}

// Procedures
add :: proc(a, b: int) -> int {
    return a + b
}

main :: proc() {
    result := add(5, 10)
    fmt.printf("5 + 10 = %d\n", result)
}

// Arrays and loops
main :: proc() {
    numbers := []int{1, 2, 3, 4, 5}
    sum := 0
    for num in numbers {
        sum += num
    }
    fmt.printf("Sum: %d\n", sum)
}

// Structs
Person :: struct {
    name: string,
    age:  int,
}

main :: proc() {
    p := Person{name = "Alice", age = 30}
    fmt.printf("%s is %d years old\n", p.name, p.age)
}

// Maps
main :: proc() {
    m := make(map[string]int)
    m["apple"] = 5
    m["banana"] = 3
    fmt.printf("Apples: %d\n", m["apple"])
}

// String operations
main :: proc() {
    s := "Hello"
    s2 := " World!"
    fmt.println(s)
    fmt.println(s2)
    fmt.printf("First length: %d\n", len(s))
    fmt.printf("Second length: %d\n", len(s2))
}

// Type inference and multiple return values
divide :: proc(a, b: int) -> (int, bool) {
    if b == 0 {
        return 0, false
    }
    return a / b, true
}

main :: proc() {
    result, ok := divide(10, 2)
    if ok {
        fmt.printf("Result: %d\n", result)
    } else {
        fmt.println("Division by zero!")
    }
}
```

## Caveats
- Fragments must be valid Odin code that compiles
- Odin uses `::` for procedure and type definitions (not `:`)
- Variables can use type inference with `:=` or explicit typing with `:`
- Arrays are value types, slices are reference types
- Maps are reference types
- Zero values: `0` for numbers, `""` for strings, `nil` for pointers/slices/maps
- String concatenation uses `strings.concatenate()` or the `+` operator (depending on context)
- Procedure syntax: `name :: proc(params) -> return_type { ... }`
- Import statements use `import "package:name"` syntax
- Odin is case-sensitive
- Memory management is explicit - no automatic garbage collection by default
