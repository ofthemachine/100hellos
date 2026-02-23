#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for CoffeeScript fraglet.
# Contract: fragment reads stdin; pipe into fragletc and assert output.

set -euo pipefail

IMAGE="${1:-100hellos/coffeescript:local}"
EXT="coffee"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
fs = require 'fs'
input = fs.readFileSync 0, 'utf8'
input.split('\n').forEach (line) ->
  console.log line.toUpperCase()
EOF
out=$(mktemp)
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 > "$out"
grep -Fq "HELLO" "$out"
echo "✓ stdin verified"
