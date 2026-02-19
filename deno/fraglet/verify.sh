#!/bin/bash
# verify.sh - Smoke tests for Deno fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/deno:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ts"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
console.log("Hello, World!");
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
function greet(name: string): string {
    return `Hello, ${name}!`;
}
console.log(greet("Alice"));
EOF
verify_fraglet "Hello, Alice"

cat > "$tmp" <<'EOF'
const numbers = [1, 2, 3, 4, 5];
const squared = numbers.map(x => x * x);
console.log(`Sum of squares: ${squared.reduce((a, b) => a + b, 0)}`);
EOF
verify_fraglet "Sum of squares:"

cat > "$tmp" <<'EOF'
const person = { name: "Bob", age: 30 };
console.log(`${person.name} is ${person.age} years old`);
EOF
verify_fraglet "Bob is 30 years old"

cat > "$tmp" <<'EOF'
const count: number = 42;
const message: string = `Count is ${count}`;
console.log(message);
EOF
verify_fraglet "Count is 42"

cat > "$tmp" <<'EOF'
async function fetchExample() {
    console.log("Async function example");
}
await fetchExample();
EOF
verify_fraglet "Async function example"

echo "✓ All tests passed"
