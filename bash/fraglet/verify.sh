#!/bin/bash
# verify.sh - Smoke tests for bash fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/bash:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.bash"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
cat > "$tmp" <<'EOF'
echo "Hello from fragment!"
EOF
verify_fraglet "Hello from fragment!"

# Example 2: Variables
cat > "$tmp" <<'EOF'
NAME="Alice"
echo "Hello, $NAME!"
EOF
verify_fraglet "Hello, Alice"

# Example 3: Arithmetic
cat > "$tmp" <<'EOF'
A=5
B=10
SUM=$((A + B))
echo "Sum: $SUM"
EOF
verify_fraglet "Sum: 15"

# Example 4: Arrays
cat > "$tmp" <<'EOF'
FRUITS=("apple" "banana" "cherry")
for fruit in "${FRUITS[@]}"; do
    echo "Fruit: $fruit"
done
EOF
verify_fraglet "Fruit: apple"

# Example 5: Conditionals
cat > "$tmp" <<'EOF'
if [[ "test" == "test" ]]; then
    echo "Testing mode"
else
    echo "Normal mode"
fi
EOF
verify_fraglet "Testing mode"

# Example 6: Functions
cat > "$tmp" <<'EOF'
greet() {
    local name="$1"
    echo "Hello, $name!"
}

greet "World"
EOF
verify_fraglet "Hello, World!"

# Example 7: Command substitution
cat > "$tmp" <<'EOF'
DATE=$(date)
echo "Current date: $DATE"
EOF
verify_fraglet "Current date:"

# Example 8: Arithmetic loops
cat > "$tmp" <<'EOF'
for i in {1..5}; do
    echo "Count: $i"
done
EOF
verify_fraglet "Count: 1"

# Example 9: Associative arrays
cat > "$tmp" <<'EOF'
declare -A colors
colors["red"]="#FF0000"
colors["green"]="#00FF00"
echo "Red: ${colors[red]}"
EOF
verify_fraglet "Red: #FF0000"

echo "✓ All tests passed"
