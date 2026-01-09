#!/bin/bash
# verify.sh - Smoke tests for BQN fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/bqn:local}"

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
•Out "Hello, World!"
EOF

# Example 2: Variables and arithmetic
verify_fraglet "15" <<'EOF'
a ← 5
b ← 10
•Out (•Repr (a + b))
EOF

# Example 3: Array operations
verify_fraglet "15" <<'EOF'
arr ← 1‿2‿3‿4‿5
sum ← +´ arr
•Out (•Repr sum)
EOF

# Example 4: Function definition (explicit)
verify_fraglet "10" <<'EOF'
Double ← {𝕩 × 2}
•Out (•Repr (Double 5))
EOF

# Example 5: Function definition (tacit)
verify_fraglet "14" <<'EOF'
DoubleTacit ← ×⟜2
•Out (•Repr (DoubleTacit 7))
EOF

# Example 6: Array generation and processing
verify_fraglet "1‿4‿9‿16‿25" <<'EOF'
squares ← ×˜ 1‿2‿3‿4‿5
•Out (•Repr squares)
EOF

# Example 7: Fold operation (Fibonacci)
verify_fraglet "0‿1" <<'EOF'
fib ← {𝕩∾+´¯2↑𝕩}⍟9 ⟨0,1⟩
•Out (•Repr (10↑fib))
EOF

echo "✓ All tests passed"
