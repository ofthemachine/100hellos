#!/bin/bash
# verify.sh - Smoke tests for Julia fraglet support
set -euo pipefail
IMAGE="${1:-100hellos/julia:local}"
verify_fraglet() { local e="$1"; fragletc --image "$IMAGE" - 2>&1 | grep -q "$e"; }
echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"
echo "Testing fraglet examples..."
verify_fraglet "Hello, World!" <<'EOF'
println("Hello, World!")
EOF
verify_fraglet "Hello, Alice" <<'EOF'
greet(name) = "Hello, $name!"
println(greet("Alice"))
EOF
echo "✓ All tests passed"
