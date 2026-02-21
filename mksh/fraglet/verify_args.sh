#!/bin/bash
# verify_args.sh - Verified capability: argument passing for mksh fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/mksh:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ksh"
printf '%s\n' 'echo "Args: $*"' > "$tmp"
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
