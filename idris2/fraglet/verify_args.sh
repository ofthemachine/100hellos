#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Idris2 fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/idris2:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.idr"
cat > "$tmp" <<'EOF'
import System
import Data.String

main : IO ()
main = do
    args <- getArgs
    putStrLn ("Args: " ++ joinBy " " (drop 1 args))
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
