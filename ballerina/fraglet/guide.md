# Ballerina Fraglet Guide

## Language Version
Ballerina (latest via SDKMAN)

## Execution Model
- Compiled language that builds to JAR files
- Code runs inside the `main()` function
- Requires `ballerina build` then `ballerina run`
- Execution handled by wrapper script

## Key Characteristics
- Statically typed
- Case-sensitive
- Java-like syntax with functional features
- Built-in support for network services, data structures, and concurrency

## Fragment Authoring
Write valid Ballerina code. Your fragment becomes the module body. This means:
- You must include `public function main() { ... }` in your fragment
- You CAN define functions, types, and other module-level constructs
- Functions are defined at module level, then called from main()

This approach enables teaching the full range of Ballerina features.

## Available Modules
- `ballerina/io` - Input/output operations (already imported)
- Standard library modules available via `import ballerina/<module>;`

## Command-line arguments
Arguments passed to your script are available as rest parameters in `main`. Use `public function main(string... args)` and iterate with `foreach`:

```ballerina
public function main(string... args) {
    foreach string arg in args {
        io:println(arg);
    }
}
```

## Stdin
Use `io:readln()` from the `ballerina/io` module to read a line from stdin. Some versions require a prompt string (use `io:readln("")` for none). It returns `string?` (nil at EOF). For line-by-line processing, loop until `readln()` returns nil:

```ballerina
public function main() {
    string? line = io:readln("");
    if line is string {
        io:println(line);
    }
}
```

For uppercase output, use `string:toUpperAscii()` from the `ballerina/lang.string` module where available.

## Common Patterns
- Print: `io:println("message");`
- Variables: `int x = 5;` or `var x = 5;`
- Strings: `string msg = "Hello";`
- Arrays: `int[] numbers = [1, 2, 3];`
- Functions: Define at module level, call from main()
- String interpolation: `io:println("Value: " + value.toString());`

## Examples

```ballerina
// Simple output
public function main() {
    io:println("Hello, World!");
}

// Variables and calculations
public function main() {
    int a = 5;
    int b = 10;
    io:println("Sum: " + (a + b).toString());
}

// Function definition (at module level)
function greet(string name) returns string {
    return "Hello, " + name + "!";
}

public function main() {
    io:println(greet("Alice"));
}

// Arrays and loops
public function main() {
    int[] numbers = [1, 2, 3, 4, 5];
    int sum = 0;
    foreach int n in numbers {
        sum += n;
    }
    io:println("Array sum: " + sum.toString());
}

// Multiple helper functions
function add(int a, int b) returns int {
    return a + b;
}

function multiply(int a, int b) returns int {
    return a * b;
}

public function main() {
    io:println("5 + 3 = " + add(5, 3).toString());
    io:println("5 * 3 = " + multiply(5, 3).toString());
}
```

## Caveats
- Fragment must include `public function main()` or `public function main(string... args)`
- Code must be valid Ballerina syntax
- Statements end with semicolons
- Type annotations are optional but recommended
- String concatenation uses `+` operator
- Numbers must be converted to strings for output: `value.toString()`
- `io:readln()` returns `string?`; check for nil when reading multiple lines or at EOF
