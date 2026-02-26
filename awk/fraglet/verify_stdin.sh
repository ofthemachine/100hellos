#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for AWK fraglet.
# Pattern-action { print toupper($0) } reads stdin and prints uppercase.
set -euo pipefail
IMAGE="${1:-100hellos/awk:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.awk"
printf '%s\n' '{ print toupper($0) }' > "$tmp"
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
