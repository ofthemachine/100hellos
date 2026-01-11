# F# Fraglet Guide

## Language Version
F# (.NET 7.0 SDK)

## Execution Model
- Compiled language using the .NET SDK
- Code is compiled and executed via `dotnet run`
- Uses .NET 7.0 runtime

## Key Characteristics
- Statically typed with type inference
- Case-sensitive
- Functional-first language with strong support for immutability
- Supports object-oriented programming (classes, interfaces, inheritance)
- Rich standard library (F# Core Library and .NET BCL)
- Modern features: pattern matching, discriminated unions, computation expressions, async/await

## Fragment Authoring
Write valid F# code. You can use top-level code for simple expressions, or define modules, functions, and types for more complex code. Your fragment will be compiled and executed.

## Available Namespaces
The template includes common open directives. You can use:
- `System` - Core types and utilities
- `System.Collections.Generic` - Collections (List, Dictionary, etc.)
- `System.Linq` - LINQ queries (via F# query expressions)
- `System.IO` - File I/O
- `System.Text` - Text encoding

## Common Patterns
- Print: `printfn "message"` or `printf "%s" "message"`
- Variables: `let x = 10` (immutable by default) or `let mutable x = 10` (mutable)
- Functions: `let add a b = a + b` or `let add (a: int) (b: int) : int = a + b`
- Lists: `let numbers = [1; 2; 3]` or `let numbers = [1..5]`
- Arrays: `let arr = [|1; 2; 3|]`
- Pattern matching: `match x with | 1 -> "one" | _ -> "other"`
- Discriminated unions: `type Result = Success of int | Error of string`
- Records: `type Person = { Name: string; Age: int }`
- Loops: `for i in 1..10 do printfn "%d" i` or `[1..10] |> List.iter (printfn "%d")`

## Examples
```fsharp
// Simple output
printfn "Hello from fragment!"

// Variables and calculations
let a = 5
let b = 10
printfn "Sum: %d" (a + b)

// Using List collection
let numbers = [1; 2; 3; 4; 5]
let sum = List.sum numbers
printfn "List sum: %d" sum

// String operations
let message = "Hello"
let fullMessage = message + " World!"
printfn "%s" fullMessage

// Simple function
let add a b = a + b
printfn "5 + 3 = %d" (add 5 3)

// Pattern matching
let describe x =
    match x with
    | 0 -> "zero"
    | 1 -> "one"
    | _ -> "other"
printfn "Describe 1: %s" (describe 1)

// List operations with pipeline
let numbers = [1..10]
let evens = numbers |> List.filter (fun x -> x % 2 = 0)
printfn "Even numbers: %A" evens

// Discriminated union
type Result = Success of int | Error of string
let result = Success 42
match result with
| Success value -> printfn "Success: %d" value
| Error msg -> printfn "Error: %s" msg

// Record type
type Person = { Name: string; Age: int }
let person = { Name = "Alice"; Age = 30 }
printfn "Name: %s, Age: %d" person.Name person.Age
```

## Caveats
- Fragments must be valid F# code that compiles
- F# uses indentation for scope (like Python), so be careful with indentation
- Variables are immutable by default - use `let mutable` for mutable variables
- F# is expression-based - most constructs return values
- Use `printfn` for output with newline, `printf` for output without newline
- List literals use semicolons: `[1; 2; 3]`, not commas
- Pattern matching is exhaustive - all cases must be handled or use `_` for catch-all
- Type inference is strong, but you can add explicit type annotations when needed
- The code is compiled fresh each time, so compilation errors will fail execution
