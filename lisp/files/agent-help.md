# Common Lisp Language Guide

## Version
SBCL (Steel Bank Common Lisp) running in non-interactive batch mode.

## Execution Context
- Code executes inside a `main` function that SBCL calls immediately.
- Output should be written with `format` or `write-line`.
- You can define functions, macros, and global variables before calling them.
- The session ends when `main` finishes; call `(quit)` if you need to exit explicitly.

## Language Fundamentals
- Everything is an s-expression: `(operator arg1 arg2 ...)`.
- Prefix notation; parentheses are significant.
- Symbols are case-insensitive but typically written uppercase by the reader.
- Lists are the core data structure; vectors use `#(...)`.
- Use `let`/`let*` for local bindings, `defun` for functions, `defparameter` for globals.

## Syntax Cheatsheet
```lisp
(format t "Hello, ~a!~%" "world")
(defun square (x) (* x x))
(let ((numbers '(1 2 3 4)))
  (mapcar #'square numbers))
(if (> x 10)
    (format t "big~%")
    (format t "small~%"))
(loop for n from 1 to 5 do (format t "~d " n))
```

## Useful Patterns
- **Side effects**: Use `format`, `write-line`, or `princ` for output.
- **Conditionals**: `if`, `when`, `unless`, and `cond` handle branching.
- **Iteration**: `loop`, `dolist`, `dotimes`, or recursion.
- **Higher-order**: `mapcar`, `reduce`, `remove-if`, `funcall`.
- **Data structures**: lists (`cons`, `list`, `append`), hash tables (`make-hash-table`, `gethash`).
- **Macros**: Define mini-languages with `defmacro` when you need compile-time code generation.

## Tips for Fragments
- Multiple expressions are allowed; they execute sequentially.
- Define helpers *before you call them* inside the fragment. Use `let`/`labels` for functions and `macrolet` for macros so everything is in scope immediately (avoid top-level `defparameter`/`defmacro` unless you also reference them later in the fragment).
- Bind helpers or load data before printing results.
- Return values are ignored unless you print them; use `format`/`write-line` to surface output.
- SBCL prints warnings/errors to stderr; handle exceptions with `handler-case` if needed.

## What You Can Build
- Numeric or symbolic calculators
- Text-processing pipelines
- Mini DSLs/macros that generate other Lisp code
- Search or reasoning utilities leveraging recursion and higher-order functions
- Quick prototypes that glue other command-line tools via `uiop:run-program`
