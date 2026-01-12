#!/bin/bash
# verify.sh - Smoke tests for racket fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/racket:local}"

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
(displayln "Hello, World!")
EOF

# Example 2: Function definition
verify_fraglet "Hello, Alice" <<'EOF'
(define (greet name)
  (string-append "Hello, " name "!"))

(displayln (greet "Alice"))
EOF

# Example 3: List processing
verify_fraglet "Sum of squares:" <<'EOF'
(define numbers '(1 2 3 4 5))
(define squared (map (lambda (x) (* x x)) numbers))
(define sum (foldl + 0 squared))
(printf "Sum of squares: ~a\n" sum)
EOF

# Example 4: Higher-order functions
verify_fraglet "20" <<'EOF'
(define (apply-twice f x)
  (f (f x)))

(displayln (number->string (apply-twice (lambda (x) (* x 2)) 5)))
EOF

echo "✓ All tests passed"
