#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Nim fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/nim:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.nim"
cat > "$tmp" <<'EOF'
import std/strutils
import std/os
var a: seq[string]
for i in 1..paramCount(): a.add paramStr(i)
echo "Args: ", a.join(" ")
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
