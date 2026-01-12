# Scheme Fraglet Guide

## Language Version
Chibi Scheme (R7RS-compliant)

## Execution Model
- Interpreted, runs directly from source
- Code executes at the top level in order
- File-based execution via shebang or interpreter

## Key Characteristics
- S-expression syntax (parentheses-based)
- Dynamic typing
- Case-sensitive
- First-class functions
- Lexical scoping
- Tail-call optimization

## Fragment Authoring
Write valid Scheme expressions. Your fragment becomes the script body, so code executes in order. Define functions and variables before using them.

## Available Libraries
- Standard Scheme procedures (R7RS)
- Chibi Scheme extensions via `(import (chibi))`
- No additional packages are pre-installed

## Common Patterns
- Output: `(display "message")` followed by `(newline)`
- Function definition: `(define (function-name args) body)`
- Variable binding: `(define variable value)`
- Let binding: `(let ((var value)) body)`
- List processing: `(map function list)`
- Conditionals: `(if condition then else)`
- Recursion: Tail-recursive functions are optimized

## Examples
```scheme
;; Simple output
(display "Hello, World!")
(newline)

;; Function definition
(define (greet name)
  (display "Hello, ")
  (display name)
  (display "!")
  (newline))

(greet "Alice")

;; List processing
(define numbers '(1 2 3 4 5))
(define squared (map (lambda (x) (* x x)) numbers))
(display "Sum of squares: ")
(display (apply + squared))
(newline)

;; Recursive function
(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(display "Factorial of 5: ")
(display (factorial 5))
(newline)
```

## Caveats
- Fragments should be idempotent—design them so repeated runs succeed without manual cleanup
- Each run starts fresh—include all setup logic in the fragment itself
- Use `(display)` for output, followed by `(newline)` for line breaks
- Chibi Scheme supports R7RS standard procedures
