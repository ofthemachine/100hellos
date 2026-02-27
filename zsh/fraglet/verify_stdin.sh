#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for zsh fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/zsh:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.zsh"
printf '%s\n' 'while read -r line; do echo "$line" | tr "a-z" "A-Z"; done' > "$tmp"
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
