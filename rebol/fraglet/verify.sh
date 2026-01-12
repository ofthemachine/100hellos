#!/bin/bash
# verify.sh - Smoke tests for REBOL fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/rebol:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello, World!" <<'EOF'
print "Hello, World!"
EOF

# Example 2: Variables and expressions
verify_fraglet "Hello, Alice" <<'EOF'
name: "Alice"
age: 30
print rejoin ["Hello, " name "! You are " age " years old."]
EOF

# Example 3: Function definition
verify_fraglet "Hello, Bob" <<'EOF'
greet: func [name] [
    rejoin ["Hello, " name "!"]
]
print greet "Bob"
EOF

# Example 4: Block processing
verify_fraglet "Sum:" <<'EOF'
numbers: [1 2 3 4 5]
sum: 0
foreach num numbers [sum: sum + num]
print rejoin ["Sum: " sum]
EOF

# Example 5: Conditional
verify_fraglet "x is greater than 5" <<'EOF'
x: 10
if x > 5 [
    print "x is greater than 5"
]
EOF

# Example 6: String operations
verify_fraglet "HELLO WORLD" <<'EOF'
text: "Hello World"
print uppercase text
EOF

echo "✓ All tests passed"
