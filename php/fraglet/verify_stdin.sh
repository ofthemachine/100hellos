#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/php:local}"
EXT=".php"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
echo strtoupper(trim(file_get_contents("php://stdin"))) . "\n";
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
