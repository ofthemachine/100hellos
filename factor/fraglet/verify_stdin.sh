#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Factor fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/factor:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.factor"
cat > "$tmp" <<'EOF'
USING: io kernel ascii ;
readln >upper print
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
