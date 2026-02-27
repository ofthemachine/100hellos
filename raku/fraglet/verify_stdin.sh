#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Raku fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/raku:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.raku"
cat > "$tmp" <<'EOF'
for $*IN.lines() -> $line {
    say $line.uc;
}
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
