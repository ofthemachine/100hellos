#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/snobol4:local}"
EXT=".sno"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
        LINE = INPUT
        OUTPUT = LINE
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "hello"
echo "✓ stdin verified"
