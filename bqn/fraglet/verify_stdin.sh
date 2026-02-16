#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for BQN fraglet.
# Contract: fragment reads stdin; pipe into fragletc and assert output.

set -euo pipefail

IMAGE="${1:-100hellos/bqn:local}"
EXT=".bqn"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
•Out ⊑•file.Lines "/dev/stdin"
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "hello"
echo "✓ stdin verified"
