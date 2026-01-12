# PicoLisp Fraglet Guide

## Language Version
PicoLisp (latest from Alpine edge repositories)

## Execution Model
- Interpreted, runs directly from source
- Code executes in order from top to bottom
- Functions are defined with `(de ...)` and can be called immediately after definition
- Use `(prinl ...)` for output to stdout
- Use `(bye)` to exit explicitly (optional, execution ends automatically)

## Key Characteristics
- S-expression syntax (Lisp-like)
- Dynamic typing
- Case-sensitive
- Functional programming style with first-class functions
- Lists are fundamental data structures
- Symbols and atoms are core concepts

## Fragment Authoring
Write valid PicoLisp expressions. Your fragment becomes the script body, so code runs at the top level of the script. Define functions before using them.

## Available Packages
Standard PicoLisp library is available. No additional packages are pre-installed.

## Common Patterns
- Output: `(prinl "message")`
- Function definition: `(de function-name (Args) Body)`
- Variable binding: `(let Var Value Body)`
- List processing: `(mapcar function list)`
- Filter: `(filter function list)`
- Reduce: `(apply function list)`
- Conditionals: `(if Condition Then Else)`
- Loops: `(for Var List Body)`
- String operations: `(chop "string")` (split to list), `(pack List)` (join list to string)

## Examples
```lisp
;; Simple output
(prinl "Hello, World!")

;; Function definition
(de greet (Name)
   (prinl (pack "Hello, " Name "!")) )

(greet "Alice")

;; List processing
(let Numbers (1 2 3 4 5)
   (let Squared (mapcar '((X) (* X X)) Numbers)
      (prinl (pack "Sum of squares: " (apply + Squared))) ) )

;; String manipulation
(let Text "Hello World"
   (prinl (pack (reverse (chop Text)))) )

;; Conditional logic
(de max (A B)
   (if (> A B) A B) )

(prinl (max 10 5))

;; List filtering
(let Numbers (1 2 3 4 5 6 7 8 9 10)
   (let Evens (filter '((X) (=0 (% X 2))) Numbers)
      (prinl (pack "Even numbers: " Evens)) ) )
```

## Caveats
- Fragments should be idempotent—design them so repeated runs succeed without manual cleanup
- Each run starts fresh—include all setup logic in the fragment itself
- PicoLisp uses parentheses extensively—ensure proper matching
- Functions are defined with `(de ...)` and can be called immediately after definition
- Use `(bye)` if you need to exit explicitly, though execution ends automatically when complete
