# TinyGo Fraglet Guide

## Language Version
TinyGo 0.38.0 (Go subset)

## Execution Model
- Compiled language using `tinygo build`
- Code is compiled to a binary, then executed
- Standard Go execution model with `main()` function in `main` package
- TinyGo is a subset of Go optimized for small targets (microcontrollers, WebAssembly, etc.)

## Key Characteristics
- Statically typed (Go subset)
- Case-sensitive (exported identifiers start with uppercase)
- Garbage collected
- Strong typing with type inference (`:=` operator)
- Package-based module system
- Built-in concurrency primitives (goroutines, channels) - limited support
- No classes (uses structs and methods instead)
- Functions are first-class citizens
- **Important**: TinyGo supports a subset of Go's standard library and features

## Fragment Authoring
Write valid TinyGo code. Your fragment can define functions, types, and the `main()` function. Package and import declarations are already in place. Your fragment will be compiled and executed.

## Available Packages
The template includes the standard library package:
- `fmt` - Formatted I/O (Println, Printf, Sprintf)

Additional standard library packages may be available (TinyGo subset):
- `strings` - String manipulation
- `strconv` - String conversions
- `os` - Operating system interface (limited)
- `math` - Mathematical functions
- `time` - Time operations (limited)
- `sync` - Synchronization primitives (limited)

**Note**: TinyGo supports a subset of Go's standard library. Some packages and features may not be available.

## Common Patterns
- Print: `fmt.Println("message")` or `fmt.Printf("format %s\n", value)`
- Variables: `var x int = 10` or `x := 10` (type inference)
- Functions: `func add(a, b int) int { return a + b }`
- Structs: `type Person struct { Name string; Age int }`
- Methods: `func (p Person) String() string { return fmt.Sprintf("%s (%d)", p.Name, p.Age) }`
- Slices: `numbers := []int{1, 2, 3}` or `numbers := make([]int, 0, 10)`
- Maps: `m := make(map[string]int)` or `m := map[string]int{"a": 1}`
- Basic loops: `for i := 0; i < 10; i++ { ... }` or `for _, num := range numbers { ... }`

## Examples
```go
// Simple output
func main() {
    fmt.Println("Hello from fragment!")
}

// Variables and calculations
func main() {
    a := 5
    b := 10
    fmt.Printf("Sum: %d\n", a+b)
}

// Functions
func add(a, b int) int {
    return a + b
}

func main() {
    result := add(5, 10)
    fmt.Printf("5 + 10 = %d\n", result)
}

// Slices and loops
func main() {
    numbers := []int{1, 2, 3, 4, 5}
    sum := 0
    for _, num := range numbers {
        sum += num
    }
    fmt.Printf("Sum: %d\n", sum)
}

// Structs and methods
type Person struct {
    Name string
    Age  int
}

func (p Person) String() string {
    return fmt.Sprintf("%s is %d years old", p.Name, p.Age)
}

func main() {
    p := Person{Name: "Alice", Age: 30}
    fmt.Println(p)
}

// Maps
func main() {
    m := map[string]int{
        "apple":  5,
        "banana": 3,
    }
    fmt.Printf("Apples: %d\n", m["apple"])
}

// String operations
func main() {
    s := "Hello"
    s += " World!"
    fmt.Println(s)
    fmt.Printf("Length: %d\n", len(s))
}
```

## Caveats
- Fragments must be valid TinyGo code that compiles
- TinyGo supports a subset of Go - some Go features may not be available
- Remember that exported identifiers (functions, types, variables) must start with uppercase
- Variables declared with `:=` must be used (Go doesn't allow unused variables)
- The code is compiled fresh each time, so compilation errors will fail execution
- TinyGo has limited support for some standard library packages
- Slices are reference types, maps are reference types
- Zero values: `0` for numbers, `""` for strings, `nil` for pointers/slices/maps/channels
- Goroutines and channels have limited support in TinyGo compared to full Go
