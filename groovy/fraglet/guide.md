# Groovy Fraglet Guide

## Language Version
Groovy 4.x

## Execution Model
- Interpreted language
- Script-based execution (no explicit class wrapper required)
- Top-level code executes immediately
- Can define classes, methods, and closures

## Key Characteristics
- Dynamic typing with optional static typing
- Case-sensitive
- Semicolons optional
- Parentheses optional for method calls
- Supports closures and functional programming

## Fragment Authoring
Write valid Groovy statements or expressions. Your fragment becomes the script body. Code executes at the top level, so expressions run immediately in order. You can define classes, methods, closures, and variables.

## Available Libraries
- Standard Groovy library
- Java standard library
- No additional dependencies pre-installed

## Common Patterns
- Print: `println("message")` or `println "message"`
- String interpolation: `"Total: ${count}"` or `"Total: $count"`
- Lists: `[1, 2, 3].sum()`
- Closures: `{ x -> x * 2 }`
- Methods: `def methodName() { }`
- Classes: `class MyClass { }`
- Ranges: `(1..10).each { println it }`
- Map literals: `[key: 'value', another: 42]`

## Examples
```groovy
// Simple output
println "Hello, World!"

// Method definition
def greet(name) {
    "Hello, ${name}!"
}

println greet("Alice")

// List processing
def numbers = [1, 2, 3, 4, 5]
def squared = numbers.collect { it * it }
println "Sum of squares: ${squared.sum()}"

// Closure usage
def multiply = { a, b -> a * b }
println "5 * 3 = ${multiply(5, 3)}"

// Class definition
class Calculator {
    def add(a, b) {
        a + b
    }
}

def calc = new Calculator()
println "10 + 20 = ${calc.add(10, 20)}"

// String interpolation
def name = "Groovy"
def version = 4
println "Welcome to ${name} ${version}!"

// Map operations
def person = [name: "Bob", age: 30]
println "${person.name} is ${person.age} years old"
```

## Caveats
- Startup time may be slower than pure interpreted languages
- Some Java types and methods are available
- Method calls without parentheses can be ambiguous in some contexts
- Closures use `it` as the default parameter name for single-parameter closures
