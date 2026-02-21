#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Raku fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/raku:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.raku"
cat > "$tmp" <<'EOF'
say "Args: @*ARGS.join(' ')";
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
