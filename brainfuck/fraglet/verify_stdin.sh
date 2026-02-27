#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Brainfuck fraglet.
# Contract: fragment reads stdin via `,`; pipe into fragletc and assert output.

set -euo pipefail

IMAGE="${1:-100hellos/brainfuck:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.bf"

# Echo one character: ,.
cat > "$tmp" <<'EOF'
,.
EOF
output=$(printf 'h' | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q 'h'

echo "✓ stdin verified"
