#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Haskell fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/haskell:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.hs"
cat > "$tmp" <<'EOF'
import System.Environment (getArgs)

main = do
  args <- getArgs
  putStrLn $ "Args: " ++ unwords args
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
