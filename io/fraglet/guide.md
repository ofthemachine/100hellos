# Io Fraglet Guide

## Language Version
Io (latest from Debian package)

## Execution Model
- Interpreted, runs directly from source
- Top-level code executes immediately
- No explicit main function required
- Message-based: everything is a message to an object

## Key Characteristics
- Prototype-based object-oriented language
- Everything is an object
- Dynamic typing
- Case-sensitive
- Minimal syntax - messages are sent to objects
- Slots are used for object attributes and methods

## Fragment Authoring
Write valid Io statements. Your fragment becomes the script body. Code executes at the top level, so messages are sent immediately in order. Use `println` or `print` for output.

## Available Packages
Standard Io libraries are available. The language includes built-in support for:
- Object manipulation
- Lists and maps
- File I/O
- Networking
- Concurrency (actors, futures, coroutines)

## Common Patterns
- Print: `"message" println` or `"message" print`
- String concatenation: `"Hello, " .. "World" println`
- Lists: `list(1, 2, 3)`
- Maps: `Map clone atPut("key", "value")`
- Methods: `method(arg1, arg2, ...)`
- Object creation: `Object clone`
- Slot assignment: `obj slot := value`
- Message passing: `object message(arguments)`

## Examples
```io
# Simple output
"Hello, World!" println

# Variable assignment and output
name := "Alice"
("Hello, " .. name .. "!") println

# List processing
numbers := list(1, 2, 3, 4, 5)
squared := numbers map(x, x * x)
sum := squared sum
("Sum of squares: " .. sum) println

# Method definition
greet := method(name,
  result := "Hello, " .. name .. "!"
  result println
)
greet("Bob")

# Object creation
Person := Object clone
Person name := ""
Person greet := method(
  ("Hello, I'm " .. self name) println
)
person := Person clone
person name := "Charlie"
person greet
```

## Caveats
- Io uses message passing - everything is a message
- Slots must be assigned before use (or use `?` for optional)
- Lists are 0-indexed
- String concatenation uses `..` operator
- Method definitions use `method(...)` syntax
- Prototype-based: objects clone from prototypes
