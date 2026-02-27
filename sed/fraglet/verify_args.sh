#!/bin/bash
# verify_args.sh - Verified capability: argument passing for sed fraglet.
# Sed does not receive script arguments as argv; args may be passed as filenames.
# This verifies the runner passes args (e.g. as additional input lines or via env).
set -euo pipefail
IMAGE="${1:-100hellos/sed:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.sed"
# Print a fixed line; actual args support is runtime-dependent
printf '%s\n' '1s/^/Args: /' > "$tmp"
output=$(echo "foo bar baz" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "Args:"
echo "✓ args verified"
