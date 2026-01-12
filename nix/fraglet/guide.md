# Nix Fraglet Guide

## Language Version
Nix 2.x (latest stable)

## Execution Model
- Functional, lazy evaluation language
- Pure expressions that evaluate to values
- Code is evaluated using `nix-instantiate --eval --strict`
- Expressions are evaluated in a pure functional context
- No side effects during evaluation (pure functional)

## Key Characteristics
- Functional programming language
- Lazy evaluation
- Immutable data structures
- Strong typing with type inference
- Pattern matching with `let ... in` expressions
- String interpolation with `${variable}`
- Lists: `[1 2 3]` (space-separated, no commas)
- Attribute sets (maps): `{ a = 1; b = 2; }`
- Functions: `x: x + 1` (lambda syntax)
- Case-sensitive
- Whitespace-sensitive (indentation matters in some contexts)

## Fragment Authoring
Write valid Nix expressions that evaluate to a string (or any printable value). Your fragment becomes the expression body. You can write:
- Simple string literals: `"Hello, World!"`
- Let expressions: `let x = "World"; in "Hello ${x}!"`
- Function calls: `builtins.toString 42`
- List operations: `builtins.concatStringsSep ", " ["a" "b" "c"]`
- Attribute set operations: `{ a = 1; b = 2; }.a`

The expression will be evaluated and the result printed (with quotes removed).

## Available Builtins
Nix provides many built-in functions:
- `builtins.toString` - Convert value to string
- `builtins.concatStringsSep` - Join strings with separator
- `builtins.length` - Get length of list
- `builtins.head` - Get first element of list
- `builtins.tail` - Get all but first element
- `builtins.elemAt` - Get element at index
- `builtins.map` - Map function over list
- `builtins.filter` - Filter list with predicate
- `builtins.foldl'` - Left fold
- `builtins.readFile` - Read file (in impure contexts)
- `builtins.pathExists` - Check if path exists
- And many more (see Nix manual)

## Common Patterns
- String literal: `"Hello, World!"`
- String interpolation: `"Hello ${name}!"`
- Let binding: `let x = 5; in x + 10`
- Lists: `[1 2 3 4 5]` (space-separated)
- List operations: `builtins.map (x: x * 2) [1 2 3]`
- Attribute sets: `{ name = "Alice"; age = 30; }`
- Attribute access: `attrs.name` or `attrs."name"`
- Functions: `x: x + 1` (anonymous) or `f: x: f x` (higher-order)
- Conditionals: `if condition then value1 else value2`
- Recursive attribute sets: `rec { a = 1; b = a + 1; }`

## Examples
```nix
# Simple string output
"Hello from fragment!"

# String interpolation with let binding
let name = "Nix"; in "Hello ${name}!"

# Calculations
let a = 5; b = 10; in builtins.toString (a + b)

# List operations
builtins.concatStringsSep ", " ["apple" "banana" "cherry"]

# List mapping
builtins.concatStringsSep " " (builtins.map (x: builtins.toString (x * 2)) [1 2 3 4 5])

# Attribute sets
let person = { name = "Alice"; age = 30; }; in "${person.name} is ${builtins.toString person.age} years old"

# Functions
let add = a: b: a + b; in builtins.toString (add 5 10)

# Conditional expressions
if true then "Yes" else "No"

# Recursive attribute sets
let attrs = rec { a = 1; b = a + 1; c = a + b; }; in builtins.toString attrs.c
```

## Caveats
- Nix is a pure functional language - no side effects during evaluation
- All values are immutable
- Lazy evaluation means expressions are only evaluated when needed
- String interpolation requires `${}` syntax
- Lists are homogeneous (all elements same type)
- Attribute sets use `;` as separator, not `,`
- Functions are curried: `f: x: y: f x y` is equivalent to `f: (x: (y: f x y))`
- The expression must evaluate to a printable value (string, number, etc.)
- Complex data structures will be printed in Nix syntax, not as plain text
- `nix-instantiate --eval --strict` evaluates strictly (no lazy evaluation delays)
