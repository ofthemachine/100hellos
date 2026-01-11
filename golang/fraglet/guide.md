# Go Fraglet Guide

## Language Version
Go 1.21

## Execution Model
- Compiled language using `go build`
- Code is compiled to a binary, then executed
- Standard Go execution model with `main()` function in `main` package

## Key Characteristics
- Statically typed
- Case-sensitive (exported identifiers start with uppercase)
- Garbage collected
- Strong typing with type inference (`:=` operator)
- Package-based module system
- Built-in concurrency primitives (goroutines, channels)
- No classes (uses structs and methods instead)
- Functions are first-class citizens

## Fragment Authoring
Write valid Go code. Your fragment can define functions, types, and the `main()` function. Package and import declarations are already in place. Your fragment will be compiled and executed.

## Available Packages
The template includes the standard library package:
- `fmt` - Formatted I/O (Println, Printf, Sprintf)

Additional standard library packages can be imported as needed:
- `strings` - String manipulation
- `strconv` - String conversions
- `os` - Operating system interface
- `io` - I/O primitives
- `math` - Mathematical functions
- `time` - Time operations
- `sync` - Synchronization primitives
- `net/http` - HTTP client and server
- `encoding/json` - JSON encoding/decoding
- And many more from the Go standard library

## Common Patterns
- Print: `fmt.Println("message")` or `fmt.Printf("format %s\n", value)`
- Variables: `var x int = 10` or `x := 10` (type inference)
- Functions: `func add(a, b int) int { return a + b }`
- Structs: `type Person struct { Name string; Age int }`
- Methods: `func (p Person) String() string { return fmt.Sprintf("%s (%d)", p.Name, p.Age) }`
- Slices: `numbers := []int{1, 2, 3}` or `numbers := make([]int, 0, 10)`
- Maps: `m := make(map[string]int)` or `m := map[string]int{"a": 1}`
- Goroutines: `go func() { ... }()`
- Channels: `ch := make(chan int)`

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
- Fragments must be valid Go code that compiles
- Remember that exported identifiers (functions, types, variables) must start with uppercase
- Variables declared with `:=` must be used (Go doesn't allow unused variables)
- The code is compiled fresh each time, so compilation errors will fail execution
- Go requires explicit error handling - functions that return errors should check them
- Slices are reference types, maps are reference types
- Zero values: `0` for numbers, `""` for strings, `nil` for pointers/slices/maps/channels
