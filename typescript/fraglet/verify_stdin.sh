#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/typescript:local}"
EXT=".ts"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
declare var require: any;
const fs = require("fs");
const input: string = fs.readFileSync("/dev/stdin", "utf8");
console.log(input.trim().toUpperCase());
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
