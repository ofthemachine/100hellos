#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/typescript:local}"
EXT=".ts"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
declare var process: any;
console.log("Args: " + process.argv.slice(2).join(" "));
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
