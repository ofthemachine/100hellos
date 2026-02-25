#!/bin/bash
# verify_args.sh - Verified capability: argument passing for REBOL fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/rebol:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.r"
cat > "$tmp" <<'EOF'
print rejoin ["Args: " to-string system/script/args]
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
