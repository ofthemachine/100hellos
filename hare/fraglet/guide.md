# Hare Fraglet Guide

## Language Version
Hare (latest from Alpine edge repositories)

## Execution Model
- Compiled language using `hare build`
- Code is compiled to a static binary, then executed
- Standard Hare execution model with `export fn main() void` as entry point
- Can also use `hare run` for quick iteration (compiles and runs in one step)

## Key Characteristics
- Statically typed systems programming language
- Case-sensitive
- Memory-safe idioms (slices, option types, bounds-checked arrays)
- No garbage collector (manual memory management)
- C-style syntax with modern features
- Module-based organization (`use` statements)
- Error handling with `!` operator (error propagation)
- Explicit semicolons required

## Fragment Authoring
Write valid Hare code. Your fragment can define functions, types, and the `main()` function. `use` statements are already in place. Your fragment will be compiled and executed.

**Important**: 
- Functions must be marked with `export` if they're the entry point
- Use `!` operator to propagate errors (e.g., `fmt::println("text")!`)
- Semicolons are required to terminate statements
- Module imports use `use` keyword (e.g., `use fmt;`)

## Available Modules
The template includes the standard library module:
- `fmt` - Formatted I/O (println, printf, etc.)

Additional standard library modules can be imported as needed:
- `strings` - String manipulation
- `strconv` - String conversions
- `os` - Operating system interface
- `io` - I/O primitives
- `math` - Mathematical functions
- `time` - Time operations
- `types` - Type utilities
- `bufio` - Buffered I/O
- `encoding::base64` - Base64 encoding
- `net::http` - HTTP client and server
- And many more from the Hare standard library

## Common Patterns
- Print: `fmt::println("message")!;` or `fmt::printfln("format {}", value)!;`
- Variables: `let x: int = 10;` or `let x = 10;` (type inference)
- Functions: `fn add(a: int, b: int) int = a + b;`
- Structs: `type person = struct { name: str, age: int };`
- Slices: `let numbers: []int = [1, 2, 3];`
- Arrays: `let arr: [5]int = [1, 2, 3, 4, 5];`
- Option types: `let x: (int | void) = 42;`
- Error handling: `result!;` (propagates error, or use `match` for handling)
- Loops: `for (let i = 0; i < len(arr); i += 1) { ... }`
- Range loops: `for (let i = 0z; i < len(slice); i += 1) { ... }`

## Examples

### Simple output
```hare
export fn main() void = {
    fmt::println("Hello from fragment!")!;
};
```

### Variables and calculations
```hare
export fn main() void = {
    let a: int = 5;
    let b: int = 10;
    fmt::printfln("Sum: {}", a + b)!;
};
```

### Functions
```hare
fn add(a: int, b: int) int = a + b;

export fn main() void = {
    let result = add(5, 10);
    fmt::printfln("5 + 10 = {}", result)!;
};
```

### Slices and loops
```hare
export fn main() void = {
    let numbers: []int = [1, 2, 3, 4, 5];
    let sum = 0;
    for (let i = 0z; i < len(numbers); i += 1) {
        sum += numbers[i];
    };
    fmt::printfln("Sum: {}", sum)!;
};
```

### Structs
```hare
type person = struct {
    name: str,
    age: int,
};

export fn main() void = {
    let p = person {
        name = "Alice",
        age = 30,
    };
    fmt::printfln("{} is {} years old", p.name, p.age)!;
};
```

### String operations
```hare
export fn main() void = {
    let s = "Hello";
    fmt::printfln("{} World!", s)!;
};
```

### Option types
```hare
fn maybe_value() (int | void) = 42;

export fn main() void = {
    match (maybe_value()) {
    case let v: int =>
        fmt::printfln("Value: {}", v)!;
    case void =>
        fmt::println("No value")!;
    };
};
```

## Caveats
- **Semicolons are required**: Hare requires explicit semicolons after statements
- **Error propagation**: Use `!` operator to propagate errors from functions that can fail
- **Type annotations**: While type inference works, explicit types are often clearer
- **Memory management**: No garbage collector - be mindful of memory allocation
- **Module syntax**: Use `use module;` for imports, access with `module::function()`
- **Export functions**: Only `export fn main()` is required, but you can export other functions
- **Index types**: Use `size` type (suffix `z`) for array/slice indices: `let i = 0z;`
