#!/bin/bash
# verify_args.sh - Verified capability: argument passing for tcsh fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/tcsh:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.tcsh"
printf '%s\n' 'echo "Args: $argv"' > "$tmp"
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
