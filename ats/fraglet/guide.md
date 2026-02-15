# ATS Fraglet Guide

## Language Version
ATS2-Postiats 0.4.2

## Execution Model
- Compiled language using patscc (ATS compiler)
- Code is compiled to a binary, then executed
- Standard ATS execution model with `main0()` function

## Key Characteristics
- Statically typed with advanced type system (dependent types, linear types)
- Functional and imperative programming paradigms
- Case-sensitive
- Requires explicit compilation step
- Strong emphasis on formal specification and static verification
- Seamless C interoperation (compiles to C)

## Fragment Authoring
Write valid ATS code that implements `main0()`. Your fragment will be compiled and executed.

Fragments can include:
- **`#include` directives** — You can put `#include` lines at the top of your fragment. They are injected into the compiled file and processed by the preprocessor, so extra libraries are available for that fragment only.
- Function definitions
- Variable declarations
- Control flow (if/else, loops)
- Print statements
- Type annotations

## Includes and libraries
The container template already has at the top of the file:
- `#include "share/atspre_staload.hats"`
- `#include "share/atspre_staload_libats_ML.hats"`

So most fragments do not need to add includes. When you need another library, add the corresponding `#include` at the top of your fragment (e.g. `#include "share/HATS/atspre_staload_libats_ML.hats"` or a libc SATS path). Paths are resolved relative to the compiler’s search path (e.g. `PATSHOME`).

## Available Libraries
With the default template includes you can use:
- Standard I/O: `print`, `println!`, `print_string`
- Command-line args: `main0{n}(argc, argv)` and `listize_argc_argv(argc, argv)` (from ML lib)
- Stdin: `stdin_ref` and `streamize_fileref_line(stdin_ref)` (from ML lib)
- C interoperation

## Command-line arguments
Use the overloaded entry point `main0{n}(argc, argv)` and convert to a list with `listize_argc_argv`:

```ats
implement main0{n}(argc, argv): void =
  let
    val args = listize_argc_argv(argc, argv)
  in
    list0_foreach(args, lam(arg) => println!(arg))
  end
```

The execution script runs the binary with `"$@"`, so arguments passed to the container appear as `argv`.

## Stdin
Read lines from standard input with `streamize_fileref_line(stdin_ref)`:

```ats
implement main0() =
  let
    val lines = streamize_fileref_line(stdin_ref)
    val () = lines.foreach()(lam x => println!(x))
  in () end
```

For a single line you can use the stream’s `head()` or iterate as above.

## Common Patterns
- Print: `print ("message\n")` or `println!(x)`
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
- Use `main0()` for no-arg entry or `main0{n}(argc, argv)` for command-line arguments (only one entry point per fragment)
- ATS has strict type checking - type errors will prevent compilation
- Code is compiled fresh each time, so compilation errors will fail execution
- Use `print` or `println!` for output. For formatted output with numbers, convert to strings or use C interoperation
