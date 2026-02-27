#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Picolisp fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/picolisp:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.l"
cat > "$tmp" <<'EOF'
(prinl (pack "Args: " (glue " " (argv))))
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
