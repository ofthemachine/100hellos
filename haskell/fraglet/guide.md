# Haskell Fraglet Guide

## Language Version
GHC (Glasgow Haskell Compiler) - latest available in Alpine

## Execution Model
- Compiled language using `ghc` (Glasgow Haskell Compiler)
- Code is compiled to a binary, then executed
- Standard Haskell execution model with `main :: IO ()` function

## Key Characteristics
- Pure functional programming language
- Lazy evaluation by default
- Statically typed with type inference
- Immutable by default
- Pattern matching
- Type classes for ad-hoc polymorphism
- Monads for handling side effects (especially I/O)
- Indentation-sensitive (layout rule)
- Case-sensitive
- Functions are first-class citizens
- Higher-order functions
- List comprehensions
- Algebraic data types

## Fragment Authoring
Write valid Haskell code. Your fragment can define functions, types, and the `main` function. Your fragment will be compiled and executed.

## Available Libraries
The template includes the standard Prelude (Haskell's standard library):
- Basic I/O: `putStrLn`, `print`, `putStr`
- List operations: `map`, `filter`, `foldl`, `foldr`, `zip`, etc.
- String operations: `++`, `length`, `reverse`, etc.
- Numeric operations: standard arithmetic operators

Additional modules can be imported as needed:
- `Data.List` - Extended list operations
- `Data.Char` - Character operations
- `System.IO` - Extended I/O operations
- `Control.Monad` - Monadic operations
- And many more from the Haskell standard library

## Common Patterns
- Print: `putStrLn "message"` or `print value`
- Variables: `let x = 10 in ...` or `x = 10` (top-level)
- Functions: `add x y = x + y` or `add :: Int -> Int -> Int; add x y = x + y`
- Pattern matching: `factorial 0 = 1; factorial n = n * factorial (n - 1)`
- List comprehensions: `[x*2 | x <- [1..10]]`
- Higher-order functions: `map (*2) [1,2,3]`
- Lambda functions: `\x -> x * 2`
- Guards: `abs x | x >= 0 = x | otherwise = -x`
- Where clauses: `f x = y * 2 where y = x + 1`
- Let expressions: `let x = 5 in x * 2`

## Examples
```haskell
-- Simple output
main = putStrLn "Hello from fragment!"

-- Variables and calculations
main = do
  let a = 5
      b = 10
  putStrLn $ "Sum: " ++ show (a + b)

-- Functions
add :: Int -> Int -> Int
add x y = x + y

main = putStrLn $ "5 + 10 = " ++ show (add 5 10)

-- Pattern matching
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

main = putStrLn $ "Factorial of 5: " ++ show (factorial 5)

-- Lists and higher-order functions
main = do
  let numbers = [1, 2, 3, 4, 5]
      sum = foldl (+) 0 numbers
  putStrLn $ "Sum: " ++ show sum

-- List comprehensions
main = do
  let squares = [x*x | x <- [1..10]]
  putStrLn $ "First 10 squares: " ++ show squares

-- String operations
main = do
  let s = "Hello"
      t = s ++ " World!"
  putStrLn t
  putStrLn $ "Length: " ++ show (length t)

-- Guards and where clauses
absolute :: Int -> Int
absolute x | x >= 0 = x
           | otherwise = -x

main = putStrLn $ "Absolute of -5: " ++ show (absolute (-5))
```

## Caveats
- Fragments must be valid Haskell code that compiles
- Remember that Haskell is case-sensitive
- Indentation matters (Haskell uses layout rule)
- Functions must be defined before they are used (or use `where`/`let`)
- Type signatures are optional but recommended for clarity
- `main` must have type `IO ()` for execution
- Use `do` notation for sequencing I/O operations
- String concatenation uses `++`, not `+`
- Use `show` to convert values to strings for printing
- Pattern matching must be exhaustive or include a catch-all case
- Lazy evaluation means expressions are evaluated only when needed
- Immutability means you can't reassign variables (use `let`/`where` for new bindings)
