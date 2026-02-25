#!/bin/bash
# verify.sh - Smoke tests for JavaScript fraglet support
set -euo pipefail
IMAGE="${1:-100hellos/javascript:local}"
verify_fraglet() { local e="$1"; fragletc --image "$IMAGE" - 2>&1 | grep -q "$e"; }
echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"
echo "Testing fraglet examples..."
verify_fraglet "Hello, World!" <<'EOF'
console.log("Hello, World!");
EOF
verify_fraglet "Hello, Alice" <<'EOF'
function greet(name) { return "Hello, " + name + "!"; }
console.log(greet("Alice"));
EOF
echo "✓ All tests passed"
