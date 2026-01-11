#!/bin/bash
# verify.sh - Smoke tests for dash fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/dash:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello from fragment!" <<'EOF'
echo "Hello from fragment!"
EOF

# Example 2: Variables
verify_fraglet "Hello, Alice" <<'EOF'
NAME="Alice"
echo "Hello, $NAME!"
EOF

# Example 3: Arithmetic
verify_fraglet "Sum: 15" <<'EOF'
A=5
B=10
SUM=$((A + B))
echo "Sum: $SUM"
EOF

# Example 4: Loops
verify_fraglet "Count: 1" <<'EOF'
for i in 1 2 3 4 5; do
    echo "Count: $i"
done
EOF

# Example 5: Conditionals
verify_fraglet "Testing mode" <<'EOF'
if [ "test" = "test" ]; then
    echo "Testing mode"
else
    echo "Normal mode"
fi
EOF

# Example 6: Functions
verify_fraglet "Hello, World!" <<'EOF'
greet() {
    local name="$1"
    echo "Hello, $name!"
}

greet "World"
EOF

# Example 7: Command substitution
verify_fraglet "Current date:" <<'EOF'
DATE=$(date)
echo "Current date: $DATE"
EOF

# Example 8: Multiple statements
verify_fraglet "First line" <<'EOF'
echo "First line"
echo "Second line"
echo "Third line"
EOF

# Example 9: Arithmetic in loops (using seq)
verify_fraglet "Number: 1" <<'EOF'
for i in $(seq 1 5); do
    echo "Number: $i"
done
EOF

# Example 10: Nested conditionals
verify_fraglet "Greeting received" <<'EOF'
if [ -n "hello" ]; then
    if [ "hello" = "hello" ]; then
        echo "Greeting received"
    else
        echo "Other argument: hello"
    fi
else
    echo "No argument provided"
fi
EOF

echo "✓ All tests passed"
