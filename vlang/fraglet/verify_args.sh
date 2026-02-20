#!/bin/bash
# verify_args.sh - Verified capability: argument passing for V fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/vlang:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.v"
cat > "$tmp" <<'EOF'
import os

fn main() {
    println('Args: ' + os.args[1..].join(' '))
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
