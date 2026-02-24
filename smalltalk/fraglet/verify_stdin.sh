#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Smalltalk fraglet.

set -euo pipefail

IMAGE="${1:-100hellos/smalltalk:local}"
EXT=".st"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
[ stdin atEnd ]
  whileFalse: [ (stdin nextLine) asUppercase displayNl ]
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -Fq "HELLO"
echo "✓ stdin verified"
