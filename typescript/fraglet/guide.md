# TypeScript Fraglet Guide

## Language Version
TypeScript 5.x (compiled to JavaScript, runs on Node.js 20.x)

## Execution Model
- Compiled language that transpiles to JavaScript
- Code is compiled with `tsc` (TypeScript compiler), then executed via Node.js
- Execution happens through a wrapper script that compiles and runs
- Code executes at the top level after compilation

## Key Characteristics
- Statically typed (with type inference)
- Case-sensitive
- Semicolons optional (ASI - Automatic Semicolon Insertion)
- Indentation is preserved from the injection point
- Type annotations are optional but recommended

## Fragment Authoring
Write valid TypeScript statements or expressions. Your fragment becomes the script body. Your fragment will be compiled and executed.

## Available Packages
Standard Node.js built-in modules are available (same as JavaScript):
- `fs` - File system operations
- `path` - Path manipulation
- `http` - HTTP server/client
- `crypto` - Cryptographic functionality
- `util` - Utility functions
- `os` - Operating system utilities
- `process` - Process information and control

TypeScript compiler (`tsc`) is available globally. No additional npm packages are pre-installed.

## Common Patterns
- Print: `console.log("message")`
- Variables: `const x: number = 10;` or `let y = 20;` (type inference)
- Functions: `function name(): void {}` or `const name = (): void => {}`
- Type annotations: `const name: string = "value";`
- Arrays: `const arr: number[] = [1, 2, 3];`
- Objects: `const obj: { key: string } = { key: "value" };`
- Template literals: `` `Value: ${value}` ``
- Interfaces: `interface Person { name: string; age: number; }`

## Examples
```typescript
// Simple output
console.log("Hello, World!");

// Function with type annotations
function greet(name: string): string {
    return `Hello, ${name}!`;
}
console.log(greet("Alice"));

// Array processing with types
const numbers: number[] = [1, 2, 3, 4, 5];
const squared: number[] = numbers.map((x: number) => x * x);
const sum: number = squared.reduce((a: number, b: number) => a + b, 0);
console.log(`Sum of squares: ${sum}`);

// Interface usage
interface Person {
    name: string;
    age: number;
}
const person: Person = { name: "Bob", age: 30 };
console.log(`${person.name} is ${person.age} years old`);
```

## Caveats
- Fragments must be valid TypeScript that compiles without errors
- Type errors will prevent execution
- Variables are scoped to the script level
- Use `console.log()` for output (not `print()`)
- Remember that Node.js is the runtime, not a browser environment (no DOM APIs)
- The code is compiled fresh each time, so compilation errors will fail execution

