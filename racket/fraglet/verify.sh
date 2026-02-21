#!/bin/bash
# verify.sh - Smoke tests for racket fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/racket:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.rkt"

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
(displayln "Hello, World!")
EOF
verify_fraglet "Hello, World!"

# Example 2: Function definition
cat > "$tmp" <<'EOF'
(define (greet name)
  (string-append "Hello, " name "!"))

(displayln (greet "Alice"))
EOF
verify_fraglet "Hello, Alice"

# Example 3: List processing
cat > "$tmp" <<'EOF'
(define numbers '(1 2 3 4 5))
(define squared (map (lambda (x) (* x x)) numbers))
(define sum (foldl + 0 squared))
(printf "Sum of squares: ~a\n" sum)
EOF
verify_fraglet "Sum of squares:"

# Example 4: Higher-order functions
cat > "$tmp" <<'EOF'
(define (apply-twice f x)
  (f (f x)))

(displayln (number->string (apply-twice (lambda (x) (* x 2)) 5)))
EOF
verify_fraglet "20"

echo "✓ All tests passed"
