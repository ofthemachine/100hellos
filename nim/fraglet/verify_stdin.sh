#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Nim fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/nim:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.nim"
cat > "$tmp" <<'EOF'
import std/strutils
try:
  while true:
    let line = readLine(stdin)
    echo line.toUpper()
except EOFError:
  discard
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
