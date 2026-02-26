#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Wren fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/wren:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.wren"
cat > "$tmp" <<'EOF'
import "os" for Process
System.print("Args: " + Process.arguments.join(" "))
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
