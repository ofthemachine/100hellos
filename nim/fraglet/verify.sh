#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/nim:local}"

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

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
let a = 5
let b = 10
echo fmt"Sum: {a + b}"
EOF

# Example 3: Procedures
verify_fraglet "5 + 10 = 15" <<'EOF'
proc add(a, b: int): int =
  return a + b

echo fmt"{5} + {10} = {add(5, 10)}"
EOF

# Example 4: Sequences and loops
verify_fraglet "Sum: 15" <<'EOF'
let numbers = @[1, 2, 3, 4, 5]
var sum = 0
for num in numbers:
  sum += num
echo fmt"Sum: {sum}"
EOF

# Example 5: String operations
verify_fraglet "Hello World!" <<'EOF'
let s = "Hello"
let result = s & " World!"
echo result
EOF

# Example 6: Conditional logic
verify_fraglet "x is greater than 5" <<'EOF'
let x = 10
if x > 5:
  echo "x is greater than 5"
else:
  echo "x is not greater than 5"
EOF

# Example 7: Mutable variables
verify_fraglet "Counter: 1" <<'EOF'
var counter = 0
counter += 1
echo fmt"Counter: {counter}"
EOF

echo "✓ All tests passed"
