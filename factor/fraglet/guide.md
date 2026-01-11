# Factor Fraglet Guide

## Language Version
Factor 0.100

## Execution Model
- Interpreted, runs directly from source files
- Code executes at the top level
- Stack-based computation model

## Key Characteristics
- **Stack-based**: Values are pushed onto and popped from a data stack
- **Postfix notation**: Operations come after operands (e.g., `2 3 +` instead of `2 + 3`)
- **Words**: Functions are called "words" in Factor
- **Quotations**: Code blocks `[ ... ]` that can be treated as data
- **Vocabularies**: Module system for organizing code
- **Case-sensitive**: Identifiers are case-sensitive
- **Comments**: Start with `!` and continue to end of line

## Fragment Authoring
Write valid Factor code. Your fragment becomes the script body. Code executes at the top level, so expressions run immediately in order.

## Available Libraries
Factor includes a rich standard library organized into vocabularies:
- `io` - Input/output operations
- `math` - Mathematical operations
- `sequences` - Sequence manipulation
- `combinators` - Higher-order functions
- `kernel` - Core language features

Use `USING:` to import vocabularies:
```factor
USING: io math sequences ;
```

## Common Patterns

### Stack Operations
```factor
! Push values onto stack
2 3

! Arithmetic operations
+    ! Adds top two values: 2 + 3 = 5
*    ! Multiplies top two values
-    ! Subtracts: 5 - 2 = 3
/    ! Divides: 6 / 2 = 3
```

### String Operations
```factor
"Hello" "World!" append    ! Concatenates: "HelloWorld!"
"Hello" " " "World!" 3append    ! Appends all: "Hello World!"
```

### Stack Manipulation
```factor
dup     ! Duplicates top of stack
drop    ! Removes top of stack
swap    ! Swaps top two stack elements
over    ! Copies second element to top
```

### Quotations
```factor
[ 2 * ]    ! Quotation that doubles a number
[ dup * ]  ! Quotation that squares a number
```

### Combinators
```factor
[ 1 + ] [ 2 * ] bi    ! Apply both functions to same value
[ 2 * ] map           ! Apply function to each element
```

## Examples

```factor
! Simple output
USING: io ;
"Hello, World!" print
```

```factor
! Stack arithmetic
USING: io math ;
5 3 + number>string print    ! Outputs: 8
```

```factor
! String concatenation
USING: io sequences ;
"Hello" " " "World!" 3append print
```

```factor
! Using quotations
USING: io math ;
5 [ 2 * ] call number>string print    ! Outputs: 10
```

```factor
! Stack manipulation
USING: io math ;
10 dup * number>string print    ! Squares 10: outputs 100
```

```factor
! Multiple operations
USING: io math ;
2 3 + 4 * number>string print    ! (2 + 3) * 4 = 20
```

```factor
! Using vocabularies
USING: io math.functions ;
4 sqrt number>string print    ! Outputs: 2.0
```

```factor
! Combinators
USING: sequences prettyprint ;
{ 1 2 3 4 5 } [ 2 * ] map .    ! Doubles each: { 2 4 6 8 10 }
```

## Caveats

- **Postfix notation**: Remember that operations come after operands
- **Stack order matters**: Values are consumed from the stack in reverse order
- **Quotations need execution**: Use `call` or combinators to execute quotations
- **Vocabulary imports**: Some operations require importing vocabularies with `USING:`
- **Stack effects**: Factor tracks stack effects, but fragments are simple and don't need explicit declarations
