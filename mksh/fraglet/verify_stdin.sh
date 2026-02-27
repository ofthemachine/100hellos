#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for mksh fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/mksh:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ksh"
printf '%s\n' 'while read -r line; do echo "$line" | tr "a-z" "A-Z"; done' > "$tmp"
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
