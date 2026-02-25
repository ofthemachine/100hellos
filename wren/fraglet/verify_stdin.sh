#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Wren fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/wren:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.wren"
cat > "$tmp" <<'EOF'
import "io" for Stdin
while (true) {
  var line = Stdin.readLine()
  if (line == null) break
  System.print(line.toUpper)
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
