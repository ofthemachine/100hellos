#!/bin/bash
# verify.sh - Smoke tests for Prolog fraglet support
set -euo pipefail
IMAGE="${1:-100hellos/prolog:local}"
verify_fraglet() { local e="$1"; fragletc --image "$IMAGE" - 2>&1 | grep -q "$e"; }
echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"
echo "Testing fraglet examples..."
verify_fraglet "Hello, World!" <<'EOF'
main :- writeln('Hello, World!').
EOF
verify_fraglet "Hello, Alice" <<'EOF'
greet(Alice) :- format("Hello, ~w!~n", [Alice]).
main :- greet(Alice).
EOF
echo "✓ All tests passed"
