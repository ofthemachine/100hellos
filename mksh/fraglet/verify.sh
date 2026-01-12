#!/bin/bash
# verify.sh - Smoke tests for mksh fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/mksh:local}"

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
print "Hello from fragment!"
EOF

# Example 2: Variables
verify_fraglet "Hello, Alice" <<'EOF'
NAME="Alice"
print "Hello, $NAME!"
EOF

# Example 3: Arithmetic
verify_fraglet "Sum: 15" <<'EOF'
A=5
B=10
SUM=$((A + B))
print "Sum: $SUM"
EOF

# Example 4: Arrays
verify_fraglet "Fruit: apple" <<'EOF'
set -A FRUITS apple banana cherry
for fruit in "${FRUITS[@]}"; do
    print "Fruit: $fruit"
done
EOF

# Example 5: Conditionals
verify_fraglet "Testing mode" <<'EOF'
if [[ "test" == "test" ]]; then
    print "Testing mode"
else
    print "Normal mode"
fi
EOF

# Example 6: Functions
verify_fraglet "Hello, World!" <<'EOF'
greet() {
    local name="$1"
    print "Hello, $name!"
}

greet "World"
EOF

# Example 7: Command substitution
verify_fraglet "Current date:" <<'EOF'
DATE=$(date)
print "Current date: $DATE"
EOF

# Example 8: Arithmetic loops
verify_fraglet "Count: 1" <<'EOF'
for i in 1 2 3 4 5; do
    print "Count: $i"
done
EOF

# Example 9: Multiple statements
verify_fraglet "First line" <<'EOF'
print "First line"
print "Second line"
print "Third line"
EOF

# Example 10: Nested conditionals
verify_fraglet "Greeting received" <<'EOF'
if [[ -n "hello" ]]; then
    if [[ "hello" == "hello" ]]; then
        print "Greeting received"
    else
        print "Other argument: hello"
    fi
else
    print "No argument provided"
fi
EOF

echo "✓ All tests passed"
