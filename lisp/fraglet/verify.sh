#!/bin/bash
# verify.sh - Smoke tests for Lisp fraglet support
set -euo pipefail
IMAGE="${1:-100hellos/lisp:local}"
verify_fraglet() { local e="$1"; fragletc --image "$IMAGE" - 2>&1 | grep -q "$e"; }
echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"
echo "Testing fraglet examples..."
verify_fraglet "Hello, World!" <<'EOF'
(princ "Hello, World!")
EOF
verify_fraglet "Hello, Alice" <<'EOF'
(defun greet (name) (format t "Hello, ~a!~%" name))
(greet "Alice")
EOF
echo "✓ All tests passed"
