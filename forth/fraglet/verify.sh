#!/bin/bash
# verify.sh - Smoke tests for forth fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/forth:local}"

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
.( Hello from fragment!) CR
bye
EOF

# Example 2: Arithmetic
verify_fraglet "15" <<'EOF'
5 10 + . CR
bye
EOF

# Example 3: Variables
verify_fraglet "30" <<'EOF'
variable a
variable b
10 a !
20 b !
a @ b @ + . CR
bye
EOF

# Example 4: Constants
verify_fraglet "100" <<'EOF'
100 constant max
max . CR
bye
EOF

# Example 5: Word definition
verify_fraglet "Hello, World!" <<'EOF'
: greet ." Hello, World!" CR ;
greet
bye
EOF

# Example 6: Conditional
verify_fraglet "First is greater" <<'EOF'
: check
  10 5 >
  if
    ." First is greater" CR
  else
    ." Second is greater or equal" CR
  then
;
check
bye
EOF

# Example 7: Loop
verify_fraglet "1" <<'EOF'
: print-numbers
  5 1 do
    i . CR
  loop
;
print-numbers
bye
EOF

# Example 8: Stack manipulation
verify_fraglet "25" <<'EOF'
5 3 2 + * . CR
bye
EOF

# Example 9: String output
verify_fraglet "Fragment test" <<'EOF'
s" Fragment test" type CR
bye
EOF

echo "✓ All tests passed"
