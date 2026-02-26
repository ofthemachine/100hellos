#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Idris2 fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/idris2:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.idr"
cat > "$tmp" <<'EOF'
main : IO ()
main = do
  l <- getLine
  putStrLn (toUpper l)
  main
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
