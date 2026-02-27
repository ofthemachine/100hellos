#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/apl:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.apl"

cat > "$tmp" <<'EOF'
⍞
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "hello"
echo "✓ stdin verified"
