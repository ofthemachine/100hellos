#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Fennel fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/fennel:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.fnl"
cat > "$tmp" <<'EOF'
(print (string.format "Args: %s" (table.concat arg " ")))
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
