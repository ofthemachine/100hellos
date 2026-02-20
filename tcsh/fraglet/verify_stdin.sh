#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for tcsh fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/tcsh:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.tcsh"
printf '%s\n' 'set line = $<' 'echo "$line" | tr "a-z" "A-Z"' > "$tmp"
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
