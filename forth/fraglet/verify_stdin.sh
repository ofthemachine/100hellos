#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/forth:local}"
EXT=".fth"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
: upcase ( c -- c' )
  dup [char] a [char] z 1+ within if 32 - then ;
: read-and-upcase
  pad 256 stdin read-line throw drop
  pad swap bounds ?do
    i c@ upcase emit
  loop cr ;
read-and-upcase bye
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
