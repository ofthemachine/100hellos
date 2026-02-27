#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Idris2 fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/idris2:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.idr"
cat > "$tmp" <<'EOF'
import Data.String

main : IO ()
main = do
    line <- getLine
    putStrLn (toUpper line)
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
