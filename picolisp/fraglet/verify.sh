#!/bin/bash
# verify.sh - Smoke tests for picolisp fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/picolisp:local}"

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
(prinl "Hello, World!")
EOF

# Example 2: Function definition
verify_fraglet "Hello, Alice!" <<'EOF'
(de greet (Name)
   (prinl (pack "Hello, " Name "!")) )

(greet "Alice")
EOF

# Example 3: List processing
verify_fraglet "Sum of squares:" <<'EOF'
(let Numbers (1 2 3 4 5)
   (let Squared (mapcar '((X) (* X X)) Numbers)
      (prinl (pack "Sum of squares: " (apply + Squared))) ) )
EOF

# Example 4: String manipulation
verify_fraglet "dlroW olleH" <<'EOF'
(let Text "Hello World"
   (prinl (pack (reverse (chop Text)))) )
EOF

# Example 5: Conditional logic
verify_fraglet "10" <<'EOF'
(de max (A B)
   (if (> A B) A B) )

(prinl (max 10 5))
EOF

# Example 6: List filtering
verify_fraglet "Even numbers:" <<'EOF'
(let Numbers (1 2 3 4 5 6 7 8 9 10)
   (let Evens (filter '((X) (=0 (% X 2))) Numbers)
      (prinl (pack "Even numbers: " Evens)) ) )
EOF

echo "✓ All tests passed"
