# Fennel Fraglet Guide

## Language Version
Fennel (latest via luarocks)

## Execution Model
- Compiled to Lua bytecode, then executed by Lua runtime
- Fragment executes as top-level code in the script
- Fennel compiler processes the fragment, then Lua executes the result
- Output must be explicit (`print`, `io.write`)

## Key Characteristics
- Lisp syntax (parentheses-based, prefix notation)
- Compiles to Lua, so has access to all Lua features
- Dynamic typing (inherited from Lua)
- Case-sensitive
- Tables are the primary data structure (Lua tables)
- Functions are first-class values
- Supports destructuring, pattern matching, and macros

## Fragment Authoring
Write valid Fennel code. Your fragment becomes the script body. Code runs at the top level of the script. Define helper functions before using them. Fennel code is compiled to Lua before execution.

## Available Libraries/Packages
Standard Lua libraries are available:
- `string` - string manipulation
- `table` - table operations
- `math` - mathematical functions
- `io` - input/output operations
- `os` - operating system interface

Fennel-specific features:
- Macros via `macro` and `macros`
- Pattern matching via `match`
- Destructuring in `let`, `var`, function parameters
- Table comprehensions

## Common Patterns
- Print: `(print "message")`
- Local variables: `(local message "Hello")`
- Tables: `(local list [1 2 3])`
- Functions: `(fn greet [name] (.. "Hello, " name "!"))`
- Iteration: `(each [i value (ipairs list)] (print value))`
- Table iteration: `(each [key value (pairs table)] (print key value))`
- Pattern matching: `(match x 1 "one" 2 "two" _ "other")`
- Destructuring: `(let [[a b c] [1 2 3]] (print a b c))`

## Examples
```fennel
;; Simple output
(print "Hello, World!")

;; Function definition
(fn greet [name]
  (.. "Hello, " name "!"))

(print (greet "Alice"))

;; Table processing
(local numbers [1 2 3 4 5])
(local sum (accumulate [sum 0
                        i value (ipairs numbers)]
              (+ sum (* value value))))
(print (.. "Sum of squares: " sum))

;; Pattern matching
(fn classify [n]
  (match n
    0 "zero"
    1 "one"
    (where n (< n 10)) "single digit"
    _ "other"))

(print (classify 5))

;; Destructuring
(let [[first second & rest] [1 2 3 4 5]]
  (print first second)
  (print "Rest:" rest))

;; Working with tables
(local person {:name "Alice" :age 30})
(print (.. "Name: " (. person :name)))
(print (.. "Age: " (. person :age)))

;; String operations
(print (string.upper "hello world"))
(print (table.concat ["apple" "banana" "cherry"] ", "))
```

## Caveats
- Fennel compiles to Lua, so Lua limitations apply
- Use `local` for variables to avoid globals
- Table access uses `.` operator: `(. table :key)` or `(. table key)`
- String concatenation uses `..` operator
- Function calls use parentheses: `(function arg1 arg2)`
- Macros are compile-time, not runtime
