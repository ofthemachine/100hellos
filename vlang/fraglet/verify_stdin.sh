#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for V fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/vlang:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.v"
cat > "$tmp" <<'EOF'
import os

fn main() {
    line := os.input('')
    println(line.to_upper())
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
