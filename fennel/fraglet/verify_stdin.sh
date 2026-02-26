#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Fennel fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/fennel:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.fnl"
cat > "$tmp" <<'EOF'
(each [line (io.lines)]
  (print (string.upper line)))
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
