#!/bin/bash
# verify.sh - Smoke tests for scheme fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/scheme:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    local output
    output=$(fragletc --image "$IMAGE" - 2>&1) || {
        echo "FAILED: fragletc execution failed:" >&2
        echo "$output" >&2
        return 1
    }
    if echo "$output" | grep -q "$expected"; then
        return 0
    else
        echo "FAILED: Expected '$expected' in output:" >&2
        echo "$output" >&2
        return 1
    fi
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello, World!" <<'EOF'
(display "Hello, World!")
(newline)
EOF

# Example 2: Function definition
verify_fraglet "Hello, Alice" <<'EOF'
(define (greet name)
  (display "Hello, ")
  (display name)
  (display "!")
  (newline))

(greet "Alice")
EOF

# Example 3: List processing
verify_fraglet "Sum of squares:" <<'EOF'
(define numbers '(1 2 3 4 5))
(define squared (map (lambda (x) (* x x)) numbers))
(display "Sum of squares: ")
(display (apply + squared))
(newline)
EOF

# Example 4: Recursive function
verify_fraglet "Factorial of 5:" <<'EOF'
(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(display "Factorial of 5: ")
(display (factorial 5))
(newline)
EOF

echo "✓ All tests passed"
