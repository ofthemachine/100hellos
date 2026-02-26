#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for REBOL fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/rebol:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.r"
cat > "$tmp" <<'EOF'
forever [
    line: input
    if none? line [break]
    print uppercase line
]
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
