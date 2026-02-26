#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Factor fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/factor:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.factor"
cat > "$tmp" <<'EOF'
USING: io io.encodings.utf8 io.lines kernel strings ;
[ [ utf8 decode-contents string>upper print ] each-line ] with-input-stream*
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
