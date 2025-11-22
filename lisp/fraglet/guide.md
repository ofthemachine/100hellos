# Common Lisp Fraglet Guide

## Language Version
SBCL (Steel Bank Common Lisp)

## Execution Model
- Expressions execute in order, exactly as written
- Top-level execution is single pass
- Session ends when execution completes
- Use `format` with `t` as the destination for output to stdout

## Key Characteristics
- S-expression syntax
- Case-sensitive (though reader normalizes symbols by default)
- Dynamic typing
- Functions are first-class values

## Fragment Authoring
Paste straight Common Lisp expressions. They execute in order, exactly as written. Define functions before using them.

## Available Packages
Standard Common Lisp functions are available. No additional ASDF systems are pre-installed.

## Common Patterns
- Output: `(format t "message~%")`
- Function definition: `(defun function-name (args) body)`
- Let binding: `(let ((var value)) body)`
- List processing: `(mapcar #'function list)`
- Reduce: `(reduce #'+ list)`
- Conditionals: `(if condition then else)`

## Examples
```lisp
;; Simple output
(format t "Hello, World!~%")

;; Function definition
(defun greet (name)
  (format t "Hello, ~a!~%" name))

(greet "Alice")

;; List processing
(let ((numbers '(1 2 3 4 5)))
  (let ((squared (mapcar (lambda (x) (* x x)) numbers)))
    (format t "Sum of squares: ~a~%" (reduce #'+ squared))))
```

## Caveats
- Fragments should be idempotent—design them so repeated runs succeed without manual cleanup
- For deterministic behavior, avoid randomness or set seeds before generating random values
- Each run starts fresh—include all setup logic in the fragment itself
- Call `(quit)` if you need to exit explicitly, though execution ends automatically when complete
