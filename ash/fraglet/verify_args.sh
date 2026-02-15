#!/bin/bash
# verify_args.sh - Verified capability: argument passing for ash fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/ash:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ash"
printf '%s\n' 'echo "Args: $*"' > "$tmp"
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
