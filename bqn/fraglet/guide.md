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
Fragments should be valid BQN statements or expressions. They are injected into the main execution block, replacing the match marker. Code runs at the top level of the script.

## Available Libraries
Standard BQN library is available. System functions (prefixed with •) provide built-in functionality:
- `•Out` - Output to stdout
- `•Show` - Show value representation
- `•Type` - Get type of value
- And many more system functions

## Common Patterns
- Output: `•Out "message"` or `•Out value`
- Strings: `"Hello, World!"`
- Numbers: `42` or `3.14`
- Arrays: `⟨1, 2, 3⟩` or `1‿2‿3` (list notation)
- Arithmetic: `+`, `-`, `×`, `÷`
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
- Fragments must be valid BQN that executes without errors
- Use `•Out` for output (not `print` or similar)
- Use `•Repr` to convert values to strings for output
- BQN does not use semicolons for statement separation - each statement on its own line
- Array notation uses `⟨⟩` for lists or `‿` for linking
- System functions require the bullet prefix (•)
- Unicode symbols are essential - use proper BQN syntax
- Make fragments idempotent—repeated runs should succeed without manual cleanup
