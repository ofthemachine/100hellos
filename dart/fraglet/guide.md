# Dart Fraglet Guide

## Language Version
Dart 3.x

## Execution Model
- Compiled to native code or JIT-compiled at runtime
- Runs via `dart run` command
- Top-level code executes when program runs

## Key Characteristics
- Statically typed (with type inference)
- Object-oriented
- Case-sensitive
- Semicolons required for statements

## Fragment Authoring
Write valid Dart statements. Your fragment becomes the `main()` function body, so code executes when the program runs. You can define functions, classes, and other constructs within the fragment scope.

## Available Packages
Standard Dart SDK libraries are available. No additional packages are pre-installed.

## Common Patterns
- Print: `print("message");`
- Variables: `var name = "value";` or `String name = "value";`
- Functions: `void functionName() { }` or `returnType functionName() { }`
- Lists: `var list = [1, 2, 3];`
- Maps: `var map = {"key": "value"};`
- String interpolation: `"Hello, $name"` or `"Sum: ${a + b}"`
- Loops: `for (var i = 0; i < 10; i++) { }` or `for (var item in list) { }`

## Examples
```dart
// Simple output
print("Hello, World!");

// Variables and calculations
var a = 5;
var b = 10;
print("Sum: ${a + b}");

// Function definition
String greet(String name) {
  return "Hello, $name!";
}
print(greet("Alice"));

// List processing
var numbers = [1, 2, 3, 4, 5];
var squared = numbers.map((x) => x * x).toList();
var sum = squared.reduce((a, b) => a + b);
print("Sum of squares: $sum");

// Loops
for (var i = 1; i <= 5; i++) {
  print("Count: $i");
}

// Maps
var person = {"name": "Bob", "age": 30};
print("${person["name"]} is ${person["age"]} years old");
```
