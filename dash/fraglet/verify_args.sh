#!/bin/bash
# verify_args.sh - Verified capability: argument passing for dash fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/dash:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.dash"
printf '%s\n' 'echo "Args: $*"' > "$tmp"
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
