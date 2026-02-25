#!/bin/bash
# verify.sh - Smoke tests for R fraglet support
set -euo pipefail
IMAGE="${1:-100hellos/r-project:local}"
verify_fraglet() { local e="$1"; fragletc --image "$IMAGE" - 2>&1 | grep -q "$e"; }
echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"
echo "Testing fraglet examples..."
verify_fraglet "Hello, World!" <<'EOF'
cat("Hello, World!\n")
EOF
verify_fraglet "Hello, Alice" <<'EOF'
greet <- function(name) paste0("Hello, ", name, "!")
cat(greet("Alice"), "\n")
EOF
echo "✓ All tests passed"
