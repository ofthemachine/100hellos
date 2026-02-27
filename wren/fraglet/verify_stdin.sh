#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Wren fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/wren:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.wren"
cat > "$tmp" <<'EOF'
import "io" for Stdin
var line = Stdin.readLine()
var upper = ""
for (c in line.codePoints) {
  if (c >= 97 && c <= 122) {
    upper = upper + String.fromCodePoint(c - 32)
  } else {
    upper = upper + String.fromCodePoint(c)
  }
}
System.print(upper)
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
