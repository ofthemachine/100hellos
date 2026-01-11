#!/bin/bash
# verify.sh - Smoke tests for deno fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/deno:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello, World!" <<'EOF'
console.log("Hello, World!");
EOF

# Example 2: Function definition
verify_fraglet "Hello, Alice" <<'EOF'
function greet(name: string): string {
    return `Hello, ${name}!`;
}
console.log(greet("Alice"));
EOF

# Example 3: Array processing
verify_fraglet "Sum of squares:" <<'EOF'
const numbers = [1, 2, 3, 4, 5];
const squared = numbers.map(x => x * x);
console.log(`Sum of squares: ${squared.reduce((a, b) => a + b, 0)}`);
EOF

# Example 4: Object manipulation
verify_fraglet "Bob is 30 years old" <<'EOF'
const person = { name: "Bob", age: 30 };
console.log(`${person.name} is ${person.age} years old`);
EOF

# Example 5: TypeScript types
verify_fraglet "Count is 42" <<'EOF'
const count: number = 42;
const message: string = `Count is ${count}`;
console.log(message);
EOF

# Example 6: Async/await (top-level)
verify_fraglet "Async function example" <<'EOF'
async function fetchExample() {
    console.log("Async function example");
}
await fetchExample();
EOF

echo "✓ All tests passed"
