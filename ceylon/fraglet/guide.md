# Ceylon Fraglet Guide

## Language Version
Ceylon (latest via SDKMAN)

## Execution Model
- Compiled language that runs on the JVM
- Code is compiled with `ceylon compile` then executed with `ceylon run`
- Requires module structure (module.ceylon + source files)
- Execution handled by wrapper script

## Key Characteristics
- Statically typed
- Case-sensitive
- Java-like syntax with modern features
- Module-based architecture
- `shared` keyword for public visibility
- Entry point is `shared void run()` function

## Fragment Authoring
Fragments replace the code after the `hello()` function. This means:
- You must include `shared void run() { ... }` in your fragment
- You CAN define functions, classes, and other module-level constructs
- Functions are defined at module level, then called from `run()`

This approach enables teaching the full range of Ceylon features.

## Available Modules
- Standard Ceylon modules available via `import <module>;`
- JVM interop available via `import java.lang { ... }`

## Common Patterns
- Print: `print("message");`
- Variables: `Integer x = 5;` or `value x = 5;`
- Strings: `String msg = "Hello";`
- Arrays: `Integer[] numbers = [1, 2, 3];`
- Functions: Define at module level, call from `run()`
- String interpolation: `print("Value: ``value``");`

## Examples

```ceylon
// Simple output
shared void run() {
    print("Hello, World!");
}
```

```ceylon
// Variables and calculations
shared void run() {
    Integer a = 5;
    Integer b = 10;
    Integer sum = a + b;
    print("Sum: ``sum``");
}
```

```ceylon
// Function definition (at module level)
String greet(String name) {
    return "Hello, ``name``!";
}

shared void run() {
    print(greet("Alice"));
}
```

```ceylon
// Arrays and loops
shared void run() {
    Integer[] numbers = [1, 2, 3, 4, 5];
    variable Integer sum = 0;
    for (n in numbers) {
        sum += n;
    }
    print("Array sum: ``sum``");
}
```

```ceylon
// Multiple helper functions
Integer add(Integer a, Integer b) {
    return a + b;
}

Integer multiply(Integer a, Integer b) {
    return a * b;
}

shared void run() {
    Integer result = multiply(add(2, 3), 4);
    print("Result: ``result``");
}
```

```ceylon
// String operations
shared void run() {
    String text = "Hello, World!";
    print("Length: ``text.size``");
    print("Uppercase: ``text.uppercased``");
    print("Contains 'World': ``text.contains("World")``");
}
```

```ceylon
// Conditionals
shared void run() {
    Integer score = 85;
    if (score >= 90) {
        print("Grade: A");
    } else if (score >= 80) {
        print("Grade: B");
    } else {
        print("Grade: C");
    }
}
```

```ceylon
// Iteration with indices
shared void run() {
    String[] fruits = ["apple", "banana", "cherry"];
    for (i -> fruit in fruits.indexed) {
        print("``i``: ``fruit``");
    }
}
```

## Notes
- Use backticks (``) for string interpolation: `` `value` ``
- Variables are immutable by default; use `variable` keyword for mutable variables
- Functions without `shared` are private to the module
- Entry point must be `shared void run()`
- Ceylon uses `Integer` (not `int`) and `String` (not `string`)
