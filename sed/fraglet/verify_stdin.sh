#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for sed fraglet.
# sed reads stdin by default; y/a-z/A-Z/ uppercases (GNU sed).
set -euo pipefail
IMAGE="${1:-100hellos/sed:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.sed"
printf '%s\n' 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' > "$tmp"
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
