#!/bin/bash
# verify.sh - Smoke tests for bash fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/bash:local}"

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

# Example 4: Arrays
verify_fraglet "Fruit: apple" <<'EOF'
FRUITS=("apple" "banana" "cherry")
for fruit in "${FRUITS[@]}"; do
    echo "Fruit: $fruit"
done
EOF

# Example 5: Conditionals
verify_fraglet "Testing mode" <<'EOF'
if [[ "test" == "test" ]]; then
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

# Example 8: Arithmetic loops
verify_fraglet "Count: 1" <<'EOF'
for i in {1..5}; do
    echo "Count: $i"
done
EOF

# Example 9: Associative arrays
verify_fraglet "Red: #FF0000" <<'EOF'
declare -A colors
colors["red"]="#FF0000"
colors["green"]="#00FF00"
echo "Red: ${colors[red]}"
EOF

echo "✓ All tests passed"
