# Janet Fraglet Guide

## Language Version
Janet (latest available via Alpine package manager)

## Execution Model
- Interpreted, runs directly from source
- Code executes at the top level of the script
- Scripts are executed directly via the `janet` command
- Janet is a functional and imperative programming language

## Key Characteristics
- Lisp-like syntax with parentheses
- Dynamic typing
- Case-sensitive
- Functional programming features (first-class functions, closures)
- Built-in data structures: arrays, tables, tuples, structs
- Code is data (homoiconic)
- Garbage collected

## Fragment Authoring
Write valid Janet expressions. Your fragment becomes the script body, so code runs directly. You can define functions, use expressions, and leverage Janet's rich standard library.

## Available Libraries
Standard Janet libraries are available:
- Core functions (map, filter, reduce, etc.)
- String manipulation functions
- Array and table operations
- I/O operations
- Math functions
- System functions

## Common Patterns
- Print: `(print "message")`
- Function definition: `(defn greet [name] (string "Hello, " name "!"))`
- Anonymous functions: `(fn [x] (* x 2))`
- Arrays: `[1 2 3]`
- Tables: `@{:a 1 :b 2}`
- Tuples: `(1 2 3)`
- Map operations: `(map inc [1 2 3])`
- Filter: `(filter even? [1 2 3 4])`
- Reduce: `(reduce + 0 [1 2 3 4])` (requires initial value)
- String concatenation: `(string "Hello" " " "World")`
- String operations: `(string/ascii-upper "hello")`, `(string/join ["a" "b"] ", ")`
- Variable binding: `(def x 10)` or `(var x 10)`

## Examples
```janet
# Simple output
(print "Hello, World!")

# Function definition
(defn greet [name]
  (string "Hello, " name "!"))

(print (greet "Alice"))

# Array processing
(def numbers [1 2 3 4 5])
(def squared (map |(* $ $) numbers))
(print "Squared:" squared)

# Filter and transform
(def evens (filter even? [1 2 3 4 5 6 7 8 9 10]))
(print "Evens:" evens)

# Reduce
(def sum (reduce + 0 [1 2 3 4 5]))
(print "Sum:" sum)

# Working with tables
(def person @{:name "Alice" :age 30})
(print "Name:" (get person :name))
(print "Age:" (get person :age))

# String operations
(print (string/ascii-upper "hello world"))
(print (string/join ["apple" "banana" "cherry"] ", "))

# Function composition
(defn square [x] (* x x))
(defn add-one [x] (+ x 1))
(def result (map (comp add-one square) [1 2 3 4]))
(print "Result:" result)
```

## Caveats
- Functions are first-class values
- Use `def` for immutable bindings, `var` for mutable variables
- Arrays and tables are mutable by default
- Janet uses prefix notation for all operations
- Comments start with `#`
- Janet supports both functional and imperative programming styles
