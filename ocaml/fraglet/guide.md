# OCaml Fraglet Guide

## Language Version
OCaml - latest available in Alpine

## Execution Model
- Compiled language using `ocamlc` (OCaml bytecode compiler)
- Code is compiled to a bytecode executable, then executed
- Standard OCaml execution model with top-level expressions or `let () = ...` pattern

## Key Characteristics
- Functional programming language with imperative features
- Strict evaluation (not lazy)
- Statically typed with type inference
- Immutable by default (but supports mutable references)
- Pattern matching
- Module system
- First-class functions and higher-order functions
- Polymorphic variants
- Indentation-insensitive (uses semicolons and keywords)
- Case-sensitive
- Strong type system with type inference
- Algebraic data types
- Exception handling

## Fragment Authoring
Write valid OCaml code. Your fragment can define functions, types, and top-level expressions. Your fragment will be compiled and executed.

## Available Libraries
The template includes the standard OCaml library:
- Basic I/O: `print_endline`, `print_string`, `print_int`, `Printf.printf`
- List operations: `List.map`, `List.filter`, `List.fold_left`, `List.fold_right`, etc.
- String operations: `String.length`, `String.sub`, `^` (concatenation), etc.
- Array operations: `Array.length`, `Array.get`, `Array.set`, etc.
- Numeric operations: standard arithmetic operators

Additional modules can be opened or used with qualified names:
- `List` - List operations
- `Array` - Array operations
- `String` - String operations
- `Printf` - Formatted printing
- `Hashtbl` - Hash tables
- And many more from the OCaml standard library

## Common Patterns
- Print: `print_endline "message"` or `Printf.printf "format" args`
- Variables: `let x = 10 in ...` or `let x = 10` (top-level)
- Functions: `let add x y = x + y` or `let add (x : int) (y : int) : int = x + y`
- Pattern matching: `match x with | 0 -> 1 | n -> n * factorial (n - 1)`
- Lists: `[1; 2; 3]` (semicolon-separated)
- Higher-order functions: `List.map (fun x -> x * 2) [1; 2; 3]`
- Anonymous functions: `fun x -> x * 2`
- Recursive functions: `let rec factorial n = ...`
- Mutable references: `let r = ref 0 in r := 5; !r`
- Unit type: `()` for side effects

## Examples
```ocaml
(* Simple output *)
let () = print_endline "Hello from fragment!"

(* Variables and calculations *)
let () =
  let a = 5 in
  let b = 10 in
  Printf.printf "Sum: %d\n" (a + b)

(* Functions *)
let add x y = x + y

let () = Printf.printf "5 + 10 = %d\n" (add 5 10)

(* Pattern matching *)
let rec factorial = function
  | 0 -> 1
  | n -> n * factorial (n - 1)

let () = Printf.printf "Factorial of 5: %d\n" (factorial 5)

(* Lists and higher-order functions *)
let () =
  let numbers = [1; 2; 3; 4; 5] in
  let sum = List.fold_left (+) 0 numbers in
  Printf.printf "Sum: %d\n" sum

(* List comprehensions using List.init *)
let () =
  let squares = List.init 10 (fun x -> (x + 1) * (x + 1)) in
  Printf.printf "First 10 squares: %s\n" 
    (String.concat "; " (List.map string_of_int squares))

(* String operations *)
let () =
  let s = "Hello" in
  let t = s ^ " World!" in
  print_endline t;
  Printf.printf "Length: %d\n" (String.length t)

(* Recursive functions with pattern matching *)
let rec fibonacci = function
  | 0 -> 0
  | 1 -> 1
  | n -> fibonacci (n - 1) + fibonacci (n - 2)

let () = Printf.printf "Fibonacci(10): %d\n" (fibonacci 10)

(* Mutable references *)
let () =
  let counter = ref 0 in
  counter := !counter + 1;
  counter := !counter + 1;
  Printf.printf "Counter: %d\n" !counter
```

## Caveats
- Fragments must be valid OCaml code that compiles
- Remember that OCaml is case-sensitive
- Use semicolons (`;`) to sequence expressions, not commas
- Lists use semicolons: `[1; 2; 3]`, not commas
- Use `let () = ...` for top-level side effects
- Functions are curried by default
- Pattern matching must be exhaustive or include a catch-all case
- Use `rec` keyword for recursive functions
- String concatenation uses `^`, not `+`
- Use `Printf.printf` for formatted output, or convert with `string_of_int`, etc.
- Mutable state requires `ref` and `:=` for assignment, `!` for dereference
- Type inference is powerful but explicit types can help with clarity
- Module system allows qualified access: `List.map`, `String.length`, etc.
