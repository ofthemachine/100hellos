#!/bin/bash
# verify.sh - Smoke tests for APL (GNU APL) fraglet support.
# Contract: default run, guide examples. Args in verify_args.sh.
set -euo pipefail

IMAGE="${1:-100hellos/apl:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.apl"

verify_fraglet() {
  local expected="$1"
  shift
  fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" 2>&1 | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
cat > "$tmp" <<'EOF'
'Hello from fragment!'
EOF
verify_fraglet "Hello from fragment!"

# Example 2: Number (expression result)
cat > "$tmp" <<'EOF'
42
EOF
verify_fraglet "42"

echo "✓ All tests passed"
