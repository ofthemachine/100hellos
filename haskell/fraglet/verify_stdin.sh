#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Haskell fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/haskell:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.hs"
cat > "$tmp" <<'EOF'
import Data.Char (toUpper)

main = interact (map toUpper)
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
