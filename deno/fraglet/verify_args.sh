#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Deno fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/deno:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ts"
cat > "$tmp" <<'EOF'
console.log("Args:", Deno.args.join(" "));
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
