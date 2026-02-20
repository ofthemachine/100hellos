#!/bin/bash
# verify.sh - Smoke tests for Scheme fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/scheme:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.scm"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Full Chibi script: (import (chibi)) for base, then code
cat > "$tmp" <<'EOF'
(import (chibi))
(display "Hello, World!")
(newline)
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
(import (chibi))
(define (greet name)
  (display "Hello, ")
  (display name)
  (display "!")
  (newline))

(greet "Alice")
EOF
verify_fraglet "Hello, Alice"

cat > "$tmp" <<'EOF'
(import (chibi))
(define numbers '(1 2 3 4 5))
(define squared (map (lambda (x) (* x x)) numbers))
(display "Sum of squares: ")
(display (apply + squared))
(newline)
EOF
verify_fraglet "Sum of squares:"

cat > "$tmp" <<'EOF'
(import (chibi))
(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(display "Factorial of 5: ")
(display (factorial 5))
(newline)
EOF
verify_fraglet "Factorial of 5:"

echo "✓ All tests passed"
