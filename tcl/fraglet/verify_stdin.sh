#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Tcl fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/tcl:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.tcl"
cat > "$tmp" <<'EOF'
while {[gets stdin line] >= 0} { puts [string toupper $line] }
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
