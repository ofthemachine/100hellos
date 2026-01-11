# Deno Fraglet Guide

## Language Version
Deno 1.x (latest stable)

## Execution Model
- Interpreted, runs directly via Deno runtime
- Code executes at the top level
- Supports both JavaScript and TypeScript out of the box
- Secure by default (no file, network, or environment access unless explicitly enabled)

## Key Characteristics
- TypeScript support built-in (no compilation step needed)
- Dynamic typing
- Case-sensitive
- Semicolons optional (ASI - Automatic Semicolon Insertion)
- ES modules by default (no CommonJS)
- Top-level await supported
- No package.json or node_modules required

## Fragment Authoring
Write valid JavaScript or TypeScript statements or expressions. Your fragment becomes the script body. Code runs at the top level of the script.

## Available APIs
Deno provides built-in APIs for:
- `console` - Console output (`console.log()`, `console.error()`, etc.)
- `Deno` - Deno-specific APIs (file system, network, environment, etc.)
- Standard JavaScript/TypeScript features (no DOM APIs)

**Note**: By default, Deno runs in secure mode. File system, network, and environment access require explicit permissions via flags (e.g., `--allow-read`, `--allow-net`). In fraglet contexts, basic console output works without permissions.

## Common Patterns
- Print: `console.log("message")`
- Variables: `const x = 10;` or `let y = 20;`
- Functions: `function name() {}` or `const name = () => {}`
- Arrow functions: `const add = (a, b) => a + b`
- Arrays: `[1, 2, 3]`
- Objects: `{ key: "value" }`
- Template literals: `` `Value: ${value}` ``
- TypeScript types: `const x: number = 10;`
- Top-level await: `const data = await fetch(...);`

## Examples
```typescript
// Simple output
console.log("Hello, World!");

// Function definition
function greet(name: string): string {
    return `Hello, ${name}!`;
}
console.log(greet("Alice"));

// Array processing
const numbers = [1, 2, 3, 4, 5];
const squared = numbers.map(x => x * x);
console.log(`Sum of squares: ${squared.reduce((a, b) => a + b, 0)}`);

// Object manipulation
const person = { name: "Bob", age: 30 };
console.log(`${person.name} is ${person.age} years old`);

// TypeScript types
const count: number = 42;
const message: string = `Count is ${count}`;
console.log(message);

// Async/await (top-level)
async function fetchExample() {
    // Note: This would require --allow-net permission in real usage
    console.log("Async function example");
}
await fetchExample();
```

## Caveats
- Fragments must be valid JavaScript/TypeScript that executes without errors
- Variables are scoped to the script level
- Use `console.log()` for output (not `print()`)
- No DOM APIs available (this is a runtime, not a browser)
- File system and network access require explicit permissions (typically not needed for fraglet examples)
- Deno uses ES modules by default (no `require()`)
