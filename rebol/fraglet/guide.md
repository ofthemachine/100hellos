# REBOL Fraglet Guide

## Language Version
REBOL 3.18.0

## Execution Model
- Interpreted, runs directly from source
- Code executes at the top level

## Key Characteristics
- Homoiconic language (code is data)
- Dynamic typing
- Case-insensitive keywords (but case-sensitive strings)
- Minimal syntax with block notation
- Built-in data types: strings, integers, blocks, words, etc.

## Fragment Authoring
Write valid REBOL statements. Your fragment becomes the script body. Code runs at the top level.

## Available Libraries
Standard REBOL library is available. No additional modules are pre-installed.

## Common Patterns
- Print: `print "message"` or `print {message}`
- Variables: `name: "Alice"`
- Blocks: `[1 2 3 4 5]`
- Functions: `add: func [a b] [a + b]`
- Conditionals: `if condition [code]`
- Loops: `foreach item block [code]`
- String concatenation: `rejoin ["Hello " name]`

## Examples
```rebol
; Simple output
print "Hello, World!"

; Variables and expressions
name: "Alice"
age: 30
print rejoin ["Hello, " name "! You are " age " years old."]

; Function definition
greet: func [name] [
    rejoin ["Hello, " name "!"]
]
print greet "Bob"

; Block processing
numbers: [1 2 3 4 5]
sum: 0
foreach num numbers [sum: sum + num]
print rejoin ["Sum: " sum]

; Conditional
x: 10
if x > 5 [
    print "x is greater than 5"
]

; String operations
text: "Hello World"
print uppercase text
print length? text
```

## Caveats
- REBOL keywords are case-insensitive, but strings are case-sensitive
- Blocks use square brackets `[]` for code and data
- Words (identifiers) don't need quotes
- Use `rejoin` for string concatenation
