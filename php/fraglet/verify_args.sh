#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/php:local}"
EXT=".php"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
echo "Args: " . implode(" ", array_slice($argv, 1)) . "\n";
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
