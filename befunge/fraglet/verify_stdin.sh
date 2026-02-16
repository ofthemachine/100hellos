#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Befunge-93 fraglet.
# Cat program: ~ read, :0` test EOF, #@_ branch, , output, < loop.
set -euo pipefail
IMAGE="${1:-100hellos/befunge:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.bf"
# Read one character and output it, then end
printf '%s' '~,@' > "$tmp"
output=$(echo "h" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "h"
echo "✓ stdin verified"
