#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Janet fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/janet:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.janet"
cat > "$tmp" <<'EOF'
(def line (string/trim (file/read stdin :line)))
(print (string/ascii-upper line))
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
