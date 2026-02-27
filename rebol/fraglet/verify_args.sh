#!/bin/bash
# verify_args.sh - Verified capability: argument passing for REBOL fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/rebol:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.r"
cat > "$tmp" <<'EOF'
print rejoin ["Args: " system/script/args]
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
