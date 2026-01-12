# Wren Fraglet Guide

## Language Version
Wren (latest from wren-cli repository)

## Execution Model
- Interpreted, runs directly from source
- Top-level code executes immediately
- No explicit main function required
- Class-based object-oriented programming

## Key Characteristics
- Class-based inheritance (not prototype-based)
- Dynamic typing
- Case-sensitive
- Clean, Ruby/Python-influenced syntax
- Fiber-based concurrency support
- Statically-typed method calls (resolved at compile time)

## Fragment Authoring
Write valid Wren code. Your fragment becomes the script body. Code executes at the top level, so classes, functions, and statements run immediately in order.

## Available Libraries
Standard Wren libraries are available:
- `System` - system operations (print, clock, etc.)
- `Math` - mathematical functions
- `Random` - random number generation
- `IO` - file I/O operations
- `OS` - operating system interface
- `Meta` - reflection and metaprogramming

## Common Patterns
- Print: `System.print("message")`
- Classes: `class MyClass { }`
- Methods: `methodName { }` or `methodName(arg) { }`
- Variables: `var name = value`
- Lists: `[1, 2, 3]`
- Maps: `{"key": "value"}`
- String interpolation: `"Hello, %(name)!"`
- Fibers: `Fiber.new { }`

## Examples
```wren
// Simple output
System.print("Hello, World!")

// Class definition
class Person {
  construct new(name) {
    _name = name
  }

  greet {
    System.print("Hello, %(_name)!")
  }
}

var person = Person.new("Alice")
person.greet

// List processing
var numbers = [1, 2, 3, 4, 5]
var sum = 0
for (number in numbers) {
  sum = sum + number
}
System.print("Sum: %(sum)")

// Map operations
var fruits = {
  "apple": 5,
  "banana": 3
}
System.print("Apples: %(fruits["apple"])")

// String interpolation
var name = "World"
System.print("Hello, %(name)!")

// Function-like methods
class Calculator {
  static add(a, b) { a + b }
  static multiply(a, b) { a * b }
}

System.print("5 + 10 = %(Calculator.add(5, 10))")
System.print("5 * 10 = %(Calculator.multiply(5, 10))")
```

## Caveats
- Classes must be defined before use
- Method calls are resolved at compile time
- Use `var` for local variables
- Private fields start with underscore (`_field`)
- String interpolation uses `%(expression)` syntax
- Fibers are cooperative (yield control explicitly)
