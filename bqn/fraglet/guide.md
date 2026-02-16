# BQN Fraglet Guide

## Language Version
BQN (CBQN implementation)

## Execution Model
- Interpreted, runs via CBQN (C-based BQN implementation)
- Code executes at the top level
- Scripts run sequentially from top to bottom
- Indentation is preserved from the injection point

## Key Characteristics
- Array-first programming: every value is an array
- Uses special Unicode symbols for operations
- System functions indicated by bullet prefix (•)
- Case-sensitive
- Both tacit (point-free) and explicit programming styles
- Mathematical notation makes code read like expressions

## Fragment Authoring
Write valid BQN statements or expressions. Your fragment becomes the script body. Code runs at the top level of the script.

## Available Libraries
Standard BQN library is available. System functions (prefixed with •) provide built-in functionality:
- `•Out` - Print a **string** to stdout (with trailing newline). Argument must be a string; use `•Repr` or `•Fmt` for numbers/arrays.
- `•Show` - Display a value (any type) in a readable form.
- `•Repr` - Convert a value to a string representation (for use with `•Out`).
- `•Type` - Get type of value
- And many more system functions

## Command-line arguments and stdin
- **Arguments**: `•args` is a list of strings passed to the script (e.g. from `fragletc ... script.bqn foo bar`). Join for display (when non-empty): `1↓∾{" "∾𝕩}¨•args`. Safe for any `•args`: `•Repr •args`.
- **Stdin**: Read via `•file.Lines "/dev/stdin"` (returns list of lines). First line: `⊑•file.Lines "/dev/stdin"`. Entire stdin as one string: `∾´•file.Lines "/dev/stdin"` (fails on empty input).

## Common Patterns
- Output: `•Out "message"` for strings; for numbers or arrays use `•Out (•Repr value)` (or `•Show value` for display).
- Strings: `"Hello, World!"`
- Numbers: `42` or `3.14`
- Arrays: `⟨1, 2, 3⟩` or `1‿2‿3` (list notation); range 0..n-1: `↕n`
- Arithmetic: `+`, `-`, `×`, `÷` (use `÷` not `/` for division)
- Functions: `{𝕩 + 1}` (explicit) or `+⟜1` (tacit)
- Modifiers: `´` (fold), `⌜` (table), `¨` (each)

## Examples
```bqn
# Simple output
•Out "Hello, World!"

# Variables and arithmetic
a ← 5
b ← 10
•Out (•Repr (a + b))

# Array operations
arr ← 1‿2‿3‿4‿5
sum ← +´ arr
•Out (•Repr sum)

# Function definition (explicit)
Double ← {𝕩 × 2}
•Out (•Repr (Double 5))

# Function definition (tacit)
DoubleTacit ← ×⟜2
•Out (•Repr (DoubleTacit 7))

# Array generation and processing
squares ← ×˜ 1‿2‿3‿4‿5
•Out (•Repr squares)

# Fold operation (Fibonacci)
fib ← {𝕩∾+´¯2↑𝕩}⍟9 ⟨0,1⟩
•Out (•Repr (10↑fib))
```

## Caveats
- `•args` is empty when the script is run with no arguments; joining (e.g. `" "⊸∾´•args`) on empty list causes an error—guard with `0<≠•args` if needed.
- Stdin via `•file.Lines "/dev/stdin"` is empty when nothing is piped; `⊑` on empty list errors—only read when input is guaranteed.
- Fragments must be valid BQN that executes without errors
- **•Out accepts only strings.** Passing a number or array (e.g. `•Out 42`) errors. Always use `•Out (•Repr value)` or `•Show value` for non-strings.
- Use `•Out` for output (not `print` or similar)
- BQN does not use semicolons for statement separation - each statement on its own line
- Array notation uses `⟨⟩` for lists or `‿` for linking
- System functions require the bullet prefix (•)
- Unicode symbols are essential - use proper BQN syntax
- Make fragments idempotent—repeated runs should succeed without manual cleanup
