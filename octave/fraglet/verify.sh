#!/bin/bash
# verify.sh - Smoke tests for Octave fraglet support
set -euo pipefail
IMAGE="${1:-100hellos/octave:local}"
verify_fraglet() { local e="$1"; fragletc --image "$IMAGE" - 2>&1 | grep -q "$e"; }
echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"
echo "Testing fraglet examples..."
verify_fraglet "Hello, World!" <<'EOF'
printf("Hello, World!\n");
EOF
verify_fraglet "Hello, Alice" <<'EOF'
function s = greet(name), s = ["Hello, " name "!"]; end
printf("%s\n", greet("Alice"));
EOF
echo "✓ All tests passed"
