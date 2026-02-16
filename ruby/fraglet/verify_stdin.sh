#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Ruby fraglet.
# Contract: fragment reads stdin; pipe into fragletc and assert output.

set -euo pipefail

IMAGE="${1:-100hellos/ruby:local}"
EXT=".rb"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
puts $stdin.read.upcase
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
