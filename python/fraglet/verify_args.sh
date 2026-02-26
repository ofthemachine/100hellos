#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Python fraglet.
# Contract: fragment receives args; fragletc passes them through.

set -euo pipefail

IMAGE="${1:-100hellos/python:local}"
EXT=".py"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
import sys
print("Args:", " ".join(sys.argv[1:]))
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
