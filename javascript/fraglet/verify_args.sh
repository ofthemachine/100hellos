#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/javascript:local}"
EXT=".js"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
const args = process.argv.slice(2);
console.log("Args: " + args.join(" "));
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
