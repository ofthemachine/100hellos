# Idris2 Fraglet Guide

## Language Version
Idris2 - latest available in Alpine

## Execution Model
- Compiled language using `idris2` compiler
- Code is compiled to a binary, then executed
- Standard Idris2 execution model with `main : IO ()` function
- Uses Chez Scheme backend by default

## Key Characteristics
- Pure functional programming language
- Dependent types (types can depend on values)
- Statically typed with type inference
- Total functions (can verify termination)
- Linear types support
- Immutable by default
- Pattern matching
- Type-driven development
- Indentation-sensitive
- Case-sensitive
- Functions are first-class citizens
- Higher-order functions
- Algebraic data types
- Type-level computation

## Fragment Authoring
Write valid Idris2 code. Your fragment can define functions, types, and the `main` function. Your fragment will be compiled and executed.

**Important**: The fragment must include a `main : IO ()` function for execution.

## Available Libraries
The template includes the standard Prelude (Idris2's standard library):
- Basic I/O: `putStrLn`, `print`, `putStr`
- List operations: `map`, `filter`, `foldl`, `foldr`, `zip`, etc.
- String operations: `++`, `length`, `reverse`, etc.
- Numeric operations: standard arithmetic operators
- `Data.Nat` - Natural numbers
- `Data.List` - List operations
- `Data.String` - String operations

Additional modules can be imported as needed:
- `Data.Vect` - Vectors indexed by length
- `Data.Fin` - Finite numbers
- `System` - System operations
- And many more from the Idris2 standard library

## Common Patterns
- Print: `putStrLn "message"` or `print value`
- Variables: `let x = 10 in ...` or `x = 10` (top-level)
- Functions: `add : Int -> Int -> Int; add x y = x + y`
- Pattern matching: `factorial : Nat -> Nat; factorial Z = 1; factorial (S k) = (S k) * factorial k`
- List comprehensions: `[x*2 | x <- [1..10]]`
- Higher-order functions: `map (*2) [1,2,3]`
- Lambda functions: `\x => x * 2`
- Dependent types: `Vect n Nat` (vector of length n)
- Type-level computation: `plus : Nat -> Nat -> Nat`

## Examples
```idris
-- Simple output
main : IO ()
main = putStrLn "Hello from fragment!"

-- Variables and calculations
main : IO ()
main = do
  let a = 5
      b = 10
  putStrLn $ "Sum: " ++ show (a + b)

-- Functions
add : Int -> Int -> Int
add x y = x + y

main : IO ()
main = putStrLn $ "5 + 10 = " ++ show (add 5 10)

-- Pattern matching
factorial : Nat -> Nat
factorial Z = 1
factorial (S k) = (S k) * factorial k

main : IO ()
main = putStrLn $ "Factorial of 5: " ++ show (factorial 5)

-- Lists and higher-order functions
main : IO ()
main = do
  let numbers = [1, 2, 3, 4, 5]
      sum = foldl (+) 0 numbers
  putStrLn $ "Sum: " ++ show sum

-- String operations
main : IO ()
main = do
  let s = "Hello"
      t = s ++ " World!"
  putStrLn t
  putStrLn $ "Length: " ++ show (length t)

-- Dependent types (Vect)
import Data.Vect

main : IO ()
main = do
  let vec : Vect 3 Int = [1, 2, 3]
  putStrLn $ "Vector: " ++ show vec
  putStrLn $ "Length: " ++ show (length vec)

-- Type-level computation
main : IO ()
main = do
  let result : Nat = plus 5 10
  putStrLn $ "5 + 10 = " ++ show result
```

## Caveats
- Fragments must be valid Idris2 code that compiles
- Remember that Idris2 is case-sensitive
- Indentation matters
- Functions must be defined before they are used (or use `where`/`let`)
- Type signatures are often required (less inference than Haskell)
- `main` must have type `IO ()` for execution
- Use `do` notation for sequencing I/O operations
- String concatenation uses `++`, not `+`
- Use `show` to convert values to strings for printing
- Pattern matching must be exhaustive or include a catch-all case
- Natural numbers use `Z` (zero) and `S k` (successor) constructors
- Integer literals are automatically converted to `Nat` or `Int` as needed
- Dependent types require explicit type annotations in many cases
- Compilation can be slower than traditional languages due to type checking
