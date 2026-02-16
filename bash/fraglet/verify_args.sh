#!/bin/bash
# verify_args.sh - Verified capability: argument passing for bash fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/bash:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.bash"
printf '%s\n' 'echo "Args: $*"' > "$tmp"
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
