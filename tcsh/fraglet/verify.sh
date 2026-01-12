#!/bin/bash
# verify.sh - Smoke tests for tcsh fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/tcsh:local}"

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
set NAME="Alice"
echo "Hello, $NAME!"
EOF

# Example 3: Arithmetic
verify_fraglet "Sum: 15" <<'EOF'
@ A = 5
@ B = 10
@ SUM = $A + $B
echo "Sum: $SUM"
EOF

# Example 4: Arrays
verify_fraglet "Fruit: apple" <<'EOF'
set FRUITS=(apple banana cherry)
foreach fruit ($FRUITS)
    echo "Fruit: $fruit"
end
EOF

# Example 5: Conditionals
verify_fraglet "Testing mode" <<'EOF'
if ("test" == "test") then
    echo "Testing mode"
else
    echo "Normal mode"
endif
EOF

# Example 6: While loops
verify_fraglet "Count: 5" <<'EOF'
@ i = 1
while ($i <= 5)
    echo "Count: $i"
    @ i++
end
EOF

# Example 7: Command substitution
verify_fraglet "Current date:" <<'EOF'
set DATE=`date`
echo "Current date: $DATE"
EOF

# Example 8: Array indexing
verify_fraglet "First: one" <<'EOF'
set ARRAY=(one two three)
echo "First: $ARRAY[1]"
EOF

echo "✓ All tests passed"
