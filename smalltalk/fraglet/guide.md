# Smalltalk (GNU Smalltalk) Fraglet Guide

## Language Version
GNU Smalltalk 3.2

## Execution Model
- Interpreted; the script file is loaded and executed in order
- Top-level expressions run immediately; class definitions are compiled then instantiation and message sends run
- No mandatory "main" — execution is top-to-bottom

## Key Characteristics
- Pure object-oriented; everything is an object and a message
- Syntax: `receiver message` or `receiver message: arg`. Keywords: `Object subclass: Name [ ... ]`
- Single inheritance; blocks for control flow: `[ ... ] value`, `condition ifTrue: [ ... ]`
- Case-sensitive; comments start with `!`

## Fragment Authoring
Your fragment is the **entire script**. Write a complete, valid GNU Smalltalk program: class definitions (if needed), then top-level expressions. You can use one-liners or full classes.

## Stdin and Arguments
- **Stdin**: Use `stdin` (standard input stream). Read a line with `stdin nextLine`; loop until empty or use `stdin contents` for full input.
- **Arguments**: Use `Smalltalk arguments` (returns a collection of command-line argument strings). Join with spaces: `(Smalltalk arguments) joinUsing: ' '`.

## Common Patterns
- Print (newline): `'Hello' displayNl` or `'Hello' printNl`
- Print (no newline): `'Hello' display` or `'Hello' print`
- Class: `Object subclass: Foo [ method [ ... ] ].`
- Block: `[ 1 + 2 ] value` → 3
- Condition: `x > 0 ifTrue: [ 'yes' displayNl ] ifFalse: [ 'no' displayNl ]`
- Loop: `1 to: 5 do: [ :i | i printNl ]`
- String join: `#('a' 'b') joinUsing: ' '`

## Examples

```smalltalk
'Hello, World!' displayNl
```

```smalltalk
Object subclass: Greeter [
  greet: name [
    ('Hello, ', name, '!') displayNl
  ]
].
(Greeter new) greet: 'Alice'.
```

```smalltalk
| numbers squared sum |
numbers := #(1 2 3 4 5).
squared := numbers collect: [ :x | x * x ].
sum := squared inject: 0 into: [ :a :b | a + b ].
('Sum of squares: ', sum printString) displayNl
```

```smalltalk
(Smalltalk arguments) joinUsing: ' ' displayNl
```

```smalltalk
[ stdin atEnd ]
  whileFalse: [ stdin nextLine displayNl ]
```

## Caveats
- Class names are global; avoid clashing with existing names in the image
- `Smalltalk arguments` is the standard way to get command-line args in GNU Smalltalk
- Stdin is the default input stream; use it for pipe input
