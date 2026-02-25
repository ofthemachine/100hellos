#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Factor fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/factor:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.factor"
cat > "$tmp" <<'EOF'
USING: command-line io kernel sequences ;
command-line get " " join "Args: " prepend print
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
