# ATS Fraglet Guide

## Language Version
ATS2-Postiats 0.4.2

## Execution Model
- Compiled language using patscc (ATS compiler)
- Code is compiled to a binary, then executed
- Build script compiles `hello-world.dats` to `hello_world` binary, then runs it
- Standard ATS execution model with `main0()` function

## Key Characteristics
- Statically typed with advanced type system (dependent types, linear types)
- Functional and imperative programming paradigms
- Case-sensitive
- Requires explicit compilation step
- Strong emphasis on formal specification and static verification
- Seamless C interoperation (compiles to C)

## Fragment Authoring
Fragments should be valid ATS code that implements `main0()`. They are injected into the source file, replacing the match markers. The fragment code will be compiled and executed.

Fragments can include:
- Function definitions
- Variable declarations
- Control flow (if/else, loops)
- Print statements
- Type annotations

## Available Libraries
Standard ATS libraries are available. The container includes:
- Standard I/O functions (`print`, `print_string`)
- Basic types and functions
- C interoperation capabilities

## Common Patterns
- Print: `print ("message\n")`
- Variables: `val x = 10`
- Functions: `fun add (a: int, b: int): int = a + b`
- Conditionals: `if condition then expr1 else expr2`
- Loops: `for* {i:nat | i <= n} .<n-i>. (i: int i) => ...`

## Examples
```ats
// Simple output
implement main0 () =
  print ("Hello from fragment!\n")

// Variables
implement main0 () =
  let
    val message = "Variables work\n"
  in
    print (message)
  end

// Conditional output
implement main0 () =
  if true then
    print ("Condition is true\n")
  else
    print ("Condition is false\n")

// Multiple print statements (using parentheses and semicolons)
implement main0 () =
  (print ("First line\n"); print ("Second line\n"); print ("Third line\n"))
```

## Caveats
- Fragments must be valid ATS code that compiles
- Remember to include `\n` in print statements for newlines
- The `main0()` function is the entry point
- ATS has strict type checking - type errors will prevent compilation
- Code is compiled fresh each time, so compilation errors will fail execution
- Use `print` for string output. For formatted output with numbers, convert to strings or use C interoperation
