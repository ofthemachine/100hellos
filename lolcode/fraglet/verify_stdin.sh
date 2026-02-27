#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/lolcode:local}"
EXT=".lang"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
I HAS A LINE
GIMMEH LINE
VISIBLE LINE
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "hello"
echo "✓ stdin verified"
