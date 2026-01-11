# Forth Fraglet Guide

## Language Version
Gforth 0.7.3

## Execution Model
- Interpreted, runs via gforth interpreter
- Stack-based execution model
- Postfix (Reverse Polish) notation
- Code executes from source file line by line
- Words (functions) are defined and executed immediately

## Key Characteristics
- **Stack-based**: All operations work with a stack
- **Postfix notation**: Operators come after operands (e.g., `5 3 +` instead of `5 + 3`)
- **Words**: Functions are called "words" and are defined with `: wordname ... ;`
- **Case-insensitive**: Traditional Forth is case-insensitive
- **Whitespace-separated**: Words are separated by whitespace
- **Immediate execution**: Code executes as it's read
- **Comments**: `\` for line comments, `( ... )` for inline comments

## Fragment Authoring
Write valid Forth code. Your fragment becomes the script body. Your fragment will execute as part of the Forth program. Remember to end with `bye` if you want to exit cleanly, or the fragment will continue executing.

## Available Words
Standard Forth words are available:
- **Stack operations**: `dup`, `drop`, `swap`, `over`, `rot`
- **Arithmetic**: `+`, `-`, `*`, `/`, `mod`
- **Comparison**: `=`, `<>`, `<`, `>`, `<=`, `>=`
- **Output**: `.` (print number), `." text"` (print string), `CR` (carriage return), `emit` (print character)
- **Control flow**: `if ... then`, `if ... else ... then`, `begin ... until`, `begin ... while ... repeat`, `do ... loop`
- **Variables**: `variable name`, `!` (store), `@` (fetch)
- **Constants**: `constant name`
- **Strings**: `s" text"` (creates counted string)

## Common Patterns

### Output
```forth
.( Hello, World!) CR
```

### Stack Operations
```forth
5 3 + . CR          \ Print 8
10 2 / . CR         \ Print 5
```

### Variables
```forth
variable x
10 x !
x @ . CR            \ Print 10
```

### Constants
```forth
42 constant answer
answer . CR         \ Print 42
```

### Conditionals
```forth
: test
  10 5 >
  if
    ." Greater" CR
  else
    ." Not greater" CR
  then
;
test
```

### Loops
```forth
: countdown
  10 0 do
    i . CR
  loop
;
countdown
```

### Word Definitions
```forth
: square dup * ;
5 square . CR       \ Print 25
```

### String Operations
```forth
s" Hello" type CR
```

## Examples

```forth
\ Simple output
.( Hello from fragment!) CR

\ Arithmetic
5 10 + . CR
.( Sum: 15) CR

\ Variables
variable a
variable b
10 a !
20 b !
a @ b @ + . CR

\ Constants
100 constant max
max . CR

\ Word definition
: greet ." Hello, World!" CR ;
greet

\ Conditional
: check
  10 5 >
  if
    ." First is greater" CR
  else
    ." Second is greater or equal" CR
  then
;
check

\ Loop
: print-numbers
  5 1 do
    i . CR
  loop
;
print-numbers

\ Stack manipulation
5 3 2 + * . CR      \ (5 * (3 + 2)) = 25

\ String output
s" Fragment test" type CR
```

## Caveats
- **Stack order matters**: `5 3 +` is different from `3 5 +` (though result is same for addition)
- **Postfix notation**: Takes time to get used to if coming from infix languages
- **Whitespace required**: Words must be separated by whitespace
- **Stack underflow**: Be careful not to pop more than you push
- **Word redefinition**: Words can be redefined, which may cause confusion
- **Case-insensitive**: Traditional Forth doesn't distinguish case
- **Comments**: `\` must be followed by space, `( ... )` must have spaces around parentheses
- **String literals**: `." text"` for immediate output, `s" text"` for string on stack
- **Exit**: Use `bye` to exit gforth cleanly, otherwise it may wait for input
