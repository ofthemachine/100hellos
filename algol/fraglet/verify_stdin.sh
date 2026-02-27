#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for ALGOL 60 (jff-algol) fraglet.
# ininteger(0, n) reads one integer from stdin.
set -euo pipefail
IMAGE="${1:-100hellos/algol:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.alg"
cat > "$tmp" <<'EOF'
begin
  integer n;
  ininteger(0, n);
  outinteger(1, n);
  newline(1);
end;
EOF
output=$(echo "42" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "42"
echo "✓ stdin verified"
