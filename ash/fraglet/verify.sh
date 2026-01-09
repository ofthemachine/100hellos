#!/bin/bash
# verify.sh - Smoke tests for ash fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/ash:local}"

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
verify_fraglet "Count:" <<'EOF'
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

echo "✓ All tests passed"
