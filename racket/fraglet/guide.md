# Racket Fraglet Guide

## Language Version
Racket (latest stable version from Alpine package repository)

## Execution Model
- Interpreted, runs directly from source
- Code executes at the top level
- Uses `#lang` declaration to specify language variant
- Scripts can be executed directly with shebang: `#!/usr/bin/env racket`

## Key Characteristics
- S-expression syntax (Lisp family)
- Dynamic typing
- Case-sensitive
- Parentheses-based syntax
- First-class functions
- Powerful macro system
- Multiple language variants via `#lang` (racket/base, racket, typed/racket, etc.)

## Fragment Authoring
Write valid Racket expressions. Your fragment becomes the script body, so code executes directly. The `#lang racket/base` declaration is already present.

## Available Packages
Standard Racket libraries are available:
- `racket/base` - Core language features
- `racket` - Extended standard library
- Standard library functions for I/O, lists, strings, etc.

## Common Patterns
- Output: `(displayln "message")` or `(printf "message\n")`
- Function definition: `(define (function-name args) body)`
- Let binding: `(let ([var value]) body)`
- List processing: `(map function list)`
- Filter: `(filter predicate list)`
- Reduce: `(foldl function init list)`
- Conditionals: `(if condition then else)`
- Lambda: `(lambda (args) body)`

## Examples
```racket
; Simple output
(displayln "Hello, World!")

; Function definition
(define (greet name)
  (string-append "Hello, " name "!"))

(displayln (greet "Alice"))

; List processing
(define numbers '(1 2 3 4 5))
(define squared (map (lambda (x) (* x x)) numbers))
(define sum (foldl + 0 squared))
(printf "Sum of squares: ~a\n" sum)

; Higher-order functions
(define (apply-twice f x)
  (f (f x)))

(displayln (number->string (apply-twice (lambda (x) (* x 2)) 5)))

; Pattern matching with match (requires racket/match module)
; Note: match is not available in racket/base, use racket or require racket/match
; For racket/base, use cond or if for pattern matching instead
```

## Caveats
- Fragments should be idempotent—design them so repeated runs succeed without manual cleanup
- Each run starts fresh—include all setup logic in the fragment itself
- The `#lang` declaration must remain at the top of the file
- Racket uses parentheses for all function calls—no implicit operators
- Use `displayln` or `printf` for output (not `print` which prints the representation)
