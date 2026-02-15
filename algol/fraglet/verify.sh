#!/bin/bash
# verify.sh - Smoke tests for ALGOL 60 (jff-algol) fraglet support.
set -euo pipefail

IMAGE="${1:-100hellos/algol:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.alg"

verify_fraglet() {
  local expected="$1"
  shift
  fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" 2>&1 | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output (full begin/end block)
cat > "$tmp" <<'EOF'
begin
  outstring (1, "Hello from fragment!\n");
end;
EOF
verify_fraglet "Hello from fragment!"

# Example 2: Integer and output
cat > "$tmp" <<'EOF'
begin
  integer n;
  n := 42;
  outinteger (1, n);
  newline (1);
end;
EOF
verify_fraglet "42"

# Example 3: Arithmetic
cat > "$tmp" <<'EOF'
begin
  integer a; integer b; integer sum;
  a := 5; b := 10;
  sum := a + b;
  outinteger (1, sum);
  newline (1);
end;
EOF
verify_fraglet "15"

echo "✓ All tests passed"
