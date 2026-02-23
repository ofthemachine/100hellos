# CoffeeScript Fraglet Guide

## Language Version
CoffeeScript 2.x (compiled to JavaScript, run on Node.js)

## Execution Model
- Source is compiled to JavaScript, then executed by Node.js
- Code runs at the top level
- No explicit main; top-level statements run in order

## Key Characteristics
- Significant whitespace (indentation defines blocks)
- No semicolons; newlines and indentation define structure
- Compiles to readable JavaScript
- Case-sensitive

## Fragment Authoring
Write valid CoffeeScript: your fragment replaces the template's executable line and **can be multiple lines**. Use normal indentation for blocks (e.g. 2 spaces). Define functions, loops, and multiple statements as needed.

## Available Packages
Node.js built-ins are available: `process`, `fs`, `path`, etc. No extra npm packages are pre-installed.

## Common Patterns
- Print: `console.log "message"`
- Variables: `x = 10`
- Functions: `greet = (name) -> "Hello, #{name}!"` or multiline with `->` and indented body
- Arrays: `[1, 2, 3]`
- String interpolation: `"Value: #{value}"`
- Arguments: `process.argv[2..]` (first two elements are node and script path)
- Stdin: `require('fs').readFileSync(0, 'utf8')` or stream with `process.stdin`

## Examples

**Simple output**
```coffeescript
console.log "Hello, World!"
```

**Function and call (multiline)**
```coffeescript
greet = (name) ->
  "Hello, #{name}!"

console.log greet "Alice"
```

**Loop and aggregation (multiline)**
```coffeescript
numbers = [1, 2, 3, 4, 5]
squared = (x * x for x in numbers)
sum = squared.reduce (a, b) -> a + b
console.log "Sum of squares: #{sum}"
```

**Reading stdin (multiline)**
```coffeescript
fs = require 'fs'
input = fs.readFileSync 0, 'utf8'
input.split('\n').forEach (line) ->
  console.log line.toUpperCase()
```

**Command-line args**
```coffeescript
args = process.argv[2..]
console.log "Args: " + args.join " "
```

## Caveats
- Output with `console.log` (Node.js API)
- Indentation must be consistent (spaces; typically 2)
- Your fragment can be as many lines as you need
