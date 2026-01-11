#!/bin/bash
# verify.sh - Smoke tests for io fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/io:local}"

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
"Hello, World!" println
EOF

# Example 2: Variable assignment and output
verify_fraglet "Hello, Alice" <<'EOF'
name := "Alice"
("Hello, " .. name .. "!") println
EOF

# Example 3: List processing
verify_fraglet "Sum of squares:" <<'EOF'
numbers := list(1, 2, 3, 4, 5)
squared := numbers map(x, x * x)
sum := squared sum
("Sum of squares: " .. sum) println
EOF

# Example 4: Method definition
verify_fraglet "Hello, Bob" <<'EOF'
greet := method(name,
  result := "Hello, " .. name .. "!"
  result println
)
greet("Bob")
EOF

# Example 5: Object creation
verify_fraglet "Hello, I'm Charlie" <<'EOF'
Person := Object clone
Person name := ""
Person greet := method(
  ("Hello, I'm " .. self name) println
)
person := Person clone
person name := "Charlie"
person greet
EOF

echo "✓ All tests passed"
