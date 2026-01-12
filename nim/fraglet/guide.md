# Nim Fraglet Guide

## Language Version
Nim (latest stable)

## Execution Model
- Compiled language using `nim c` (compile to C, then compile C to binary)
- Code is compiled to a binary executable, then executed
- Top-level code executes when the program runs
- Procedures (functions) can be defined and called

## Key Characteristics
- Statically typed with type inference (`let`, `var`)
- Indentation-sensitive (like Python)
- Case-insensitive identifiers (style-insensitive)
- Garbage collected (default)
- Strong typing with type inference
- Procedures are first-class citizens
- Supports both imperative and functional programming styles
- Compiles to C/C++ for native performance

## Fragment Authoring
Write valid Nim code. Your fragment can define procedures, variables, and top-level execution code. Import statements are already in place. Your fragment will be compiled and executed.

## Available Libraries
The template includes the standard library package:
- `std/strformat` - String formatting (`fmt` macro)

Additional standard library packages can be imported as needed:
- `std/os` - Operating system interface
- `std/strutils` - String utilities
- `std/sequtils` - Sequence utilities
- `std/math` - Mathematical functions
- `std/times` - Time operations
- `std/json` - JSON encoding/decoding
- `std/httpclient` - HTTP client
- And many more from the Nim standard library

## Common Patterns
- Print: `echo "message"` or `echo fmt"formatted {value}"`
- Variables: `let x = 10` (immutable) or `var x = 10` (mutable)
- Type annotations: `let x: int = 10`
- Procedures: `proc add(a, b: int): int = a + b`
- Procedures with body: `proc greet(name: string): string = return "Hello, " & name`
- Sequences: `let numbers = @[1, 2, 3]` or `var numbers = newSeq[int]()`
- Tables (maps): `import std/tables; let m = {"key": "value"}.toTable`
- Loops: `for item in items: echo item`
- Conditionals: `if condition: echo "yes" else: echo "no"`
- String concatenation: `let s = "Hello" & " " & "World"`

## Examples
```nim
# Simple output
echo "Hello from fragment!"

# Variables and calculations
let a = 5
let b = 10
echo fmt"Sum: {a + b}"

# Procedures
proc add(a, b: int): int =
  return a + b

echo fmt"{5} + {10} = {add(5, 10)}"

# Sequences and loops
let numbers = @[1, 2, 3, 4, 5]
var sum = 0
for num in numbers:
  sum += num
echo fmt"Sum: {sum}"

# String operations
let s = "Hello"
let result = s & " World!"
echo result
echo fmt"Length: {result.len}"

# Conditional logic
let x = 10
if x > 5:
  echo "x is greater than 5"
else:
  echo "x is not greater than 5"

# Mutable variables
var counter = 0
counter += 1
echo fmt"Counter: {counter}"
```

## Caveats
- Fragments must be valid Nim code that compiles
- Indentation is significant (use spaces, typically 2 spaces)
- Variables declared with `let` are immutable, use `var` for mutable variables
- The code is compiled fresh each time, so compilation errors will fail execution
- Type inference is powerful but explicit types can improve clarity
- String concatenation uses `&` operator, not `+`
- Sequences use `@[]` syntax for literals
- Style-insensitive means `helloWorld` and `hello_world` are the same identifier
- Top-level code executes immediately when the program runs
