#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for REBOL fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/rebol:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.r"
cat > "$tmp" <<'EOF'
line: input
print uppercase line
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
