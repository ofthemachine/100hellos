#!/bin/bash
# verify.sh - Smoke tests for Lua fraglet support
set -euo pipefail
IMAGE="${1:-100hellos/lua:local}"
verify_fraglet() { local e="$1"; fragletc --image "$IMAGE" - 2>&1 | grep -q "$e"; }
echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"
echo "Testing fraglet examples..."
verify_fraglet "Hello, World!" <<'EOF'
print("Hello, World!")
EOF
verify_fraglet "Hello, Alice" <<'EOF'
local function greet(name) return string.format("Hello, %s!", name) end
print(greet("Alice"))
EOF
echo "✓ All tests passed"
