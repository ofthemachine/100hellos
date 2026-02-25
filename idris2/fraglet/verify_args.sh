#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Idris2 fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/idris2:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.idr"
cat > "$tmp" <<'EOF'
main : IO ()
main = do
  args <- getArgs
  putStrLn ("Args: " ++ unwords args)
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
