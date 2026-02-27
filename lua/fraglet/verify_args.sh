#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/lua:local}"
EXT=".lua"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
print("Args: " .. table.concat(arg, " "))
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
