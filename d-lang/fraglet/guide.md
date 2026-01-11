# D Fraglet Guide

## Language Version
D (GDC compiler, musl libc)

## Execution Model
- Compiled language using GDC (GNU D Compiler)
- Code is compiled to a binary, then executed
- Standard D execution model with `main()` function

## Key Characteristics
- Statically typed with type inference (`auto`)
- Case-sensitive
- Multi-paradigm (procedural, object-oriented, functional, generic)
- Garbage collected by default (with manual memory management options)
- Rich standard library (Phobos)
- Module-based organization
- Requires explicit compilation step
- Uses musl libc (Alpine's C library)

## Fragment Authoring
Write valid D code. Your fragment can define classes, functions, structs, and the `main()` function. Import declarations are already in place. Your fragment will be compiled and executed.

## Available Modules
The template includes these standard library modules:
- `std.stdio` - Input/output (writeln, readln, File operations)
- Standard D library (Phobos) is available

## Common Patterns
- Print: `writeln("message");`
- Variables: `int x = 10;` or `auto x = 10;`
- Classes: `class MyClass { ... }`
- Structs: `struct MyStruct { ... }`
- Functions: `int add(int a, int b) { return a + b; }`
- Templates: `T max(T)(T a, T b) { ... }`
- Arrays: `int[] arr = [1, 2, 3];`
- Strings: `string s = "Hello";`
- Ranges: `foreach (item; range) { ... }`
- Loops: `for (int i = 0; i < 10; i++) { ... }` or `foreach (i; 0..10) { ... }`

## Examples
```d
// Simple output
void main() {
    writeln("Hello from fragment!");
}

// Variables and calculations
void main() {
    int a = 5;
    int b = 10;
    writeln("Sum: ", a + b);
}

// Arrays and ranges
void main() {
    int[] numbers = [1, 2, 3, 4, 5];
    int sum = 0;
    foreach (num; numbers) {
        sum += num;
    }
    writeln("Array sum: ", sum);
}

// String operations
void main() {
    string message = "Hello";
    message ~= " World!";
    writeln(message);
}

// Simple class
class Calculator {
    int add(int a, int b) {
        return a + b;
    }
}

void main() {
    auto calc = new Calculator();
    writeln("5 + 3 = ", calc.add(5, 3));
}

// Template function
T maximum(T)(T a, T b) {
    return (a > b) ? a : b;
}

void main() {
    writeln("Max(5, 10) = ", maximum(5, 10));
    writeln("Max(3.14, 2.71) = ", maximum(3.14, 2.71));
}
```

## Caveats
- Fragments must be valid D code that compiles
- Remember that `writeln` automatically adds a newline
- Variables, classes, and functions are scoped to the module
- The code is compiled fresh each time, so compilation errors will fail execution
- musl libc may have some differences from glibc in edge cases
- Use `~` operator for string concatenation
- D uses `foreach` for iteration, which is more idiomatic than traditional `for` loops
