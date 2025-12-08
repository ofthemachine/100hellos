# JavaScript Fraglet Guide

## Language Version
Node.js 20.x

## Execution Model
- Interpreted, runs directly via Node.js
- Code executes at the top level
- Uses CommonJS module system by default
- ES modules available with `.mjs` extension or `"type": "module"` in package.json

## Key Characteristics
- Dynamic typing
- Case-sensitive
- Semicolons optional (ASI - Automatic Semicolon Insertion)
- Indentation is preserved from the injection point

## Fragment Authoring
Fragments should be valid JavaScript statements or expressions. They are injected into the main execution block, replacing the match marker. Code runs at the top level of the script.

## Available Packages
Standard Node.js built-in modules are available:
- `fs` - File system operations
- `path` - Path manipulation
- `http` - HTTP server/client
- `crypto` - Cryptographic functionality
- `util` - Utility functions
- `os` - Operating system utilities
- `process` - Process information and control

No additional npm packages are pre-installed. To use npm packages, you would need to install them (though this is typically not done in fraglet contexts).

## Common Patterns
- Print: `console.log("message")`
- Variables: `const x = 10;` or `let y = 20;`
- Functions: `function name() {}` or `const name = () => {}`
- Arrays: `[1, 2, 3]`
- Objects: `{ key: "value" }`
- Template literals: `` `Value: ${value}` ``
- Arrow functions: `const add = (a, b) => a + b`

## Examples
```javascript
// Simple output
console.log("Hello, World!");

// Function definition
function greet(name) {
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
```

## Caveats
- Fragments must be valid JavaScript that executes without errors
- Variables are scoped to the script level
- Use `console.log()` for output (not `print()`)
- Remember that Node.js is the runtime, not a browser environment (no DOM APIs)

