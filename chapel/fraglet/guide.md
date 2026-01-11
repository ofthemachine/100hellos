# Chapel Fraglet Guide

## Language Version
Chapel 2.5.0 (compiled from source with system LLVM)

## Execution Model
- Compiled language using `chpl` (Chapel compiler)
- Code is compiled to a binary, then executed
- Standard Chapel execution model with `proc main()` procedure

## Key Characteristics
- Statically typed with type inference
- Case-sensitive
- Requires explicit compilation step
- Designed for parallel and distributed computing
- Supports both shared and distributed memory parallelism
- Uses domains and arrays for data structures

## Fragment Authoring
Write valid Chapel code. Your fragment becomes the module body. This means:
- You must include `proc main() { ... }` in your fragment
- You CAN define procedures, functions, and other module-level constructs
- Procedures and functions are defined at module level, then called from main()

This approach enables teaching the full range of Chapel features, including procedure definitions and parallel computing patterns.

## Available Modules
Standard Chapel modules are available:
- `IO` - Input/output operations (writeln, read, etc.)
- `Math` - Mathematical operations (sin, cos, sqrt, etc.)
- `Random` - Random number generationa
- `Time` - Time operations
- `List` - List data structures
- `Map` - Map/dictionary data structures
- `Set` - Set data structures

## Common Patterns
- Output: `writeln("message");`
- Variables: `var x = 10;` or `var x: int = 10;`
- Procedures: `proc name() { ... }` (define at module level)
- Functions: `proc add(a: int, b: int): int { return a + b; }` (define at module level)
- Arrays: `var arr: [1..10] int;`
- Domains: `const D = {1..10, 1..5};`
- Parallel loops: `forall i in 1..10 do writeln(i);`
- Concurrent tasks: `cobegin { task1(); task2(); }`
- Reductions: `var sum = + reduce [i in 1..10] i;`

## Examples

```chapel
// Simple output
proc main() {
    writeln("Hello from fragment!");
}

// Variables and calculations
proc main() {
    var a = 5;
    var b = 10;
    writeln("Sum: ", a + b);
}

// Procedure definition (at module level)
proc greet(name: string) {
    writeln("Hello, ", name, "!");
}

proc main() {
    greet("Alice");
}

// Parallel iteration
proc main() {
    forall i in 1..5 do
        writeln("Count: ", i);
}

// Arrays and reductions
proc main() {
    var numbers: [1..5] int = [1, 2, 3, 4, 5];
    var sum = + reduce numbers;
    writeln("Array sum: ", sum);
}

// Concurrent tasks
proc main() {
    cobegin {
        writeln("Task 1");
        writeln("Task 2");
    }
}

// Domain and array operations
proc main() {
    const D = {1..3, 1..3};
    var matrix: [D] int;
    forall (i, j) in D do
        matrix[i, j] = i * j;
    writeln("Matrix[2,2] = ", matrix[2, 2]);
}

// Multiple helper procedures
proc add(a: int, b: int): int {
    return a + b;
}

proc multiply(a: int, b: int): int {
    return a * b;
}

proc main() {
    writeln("5 + 3 = ", add(5, 3));
    writeln("5 * 3 = ", multiply(5, 3));
}
```

## Caveats
- Fragment must include `proc main() { ... }`
- Code must be valid Chapel code that compiles
- Chapel is case-sensitive
- Type inference is available but explicit types can be specified
- Parallel constructs (forall, cobegin) may execute in any order
- The code is compiled fresh each time, so compilation errors will fail execution
- Chapel uses `writeln()` for output (not `print()`)
- String concatenation uses `,` operator in writeln (or `+` for string concatenation)
- Arrays are indexed with `[i]` syntax
- Domains define the shape and size of arrays
