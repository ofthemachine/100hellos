#!/bin/bash
# verify_args.sh - Verified capability: argument passing for BQN fraglet.
# Contract: fragment receives args; fragletc passes them through.

set -euo pipefail

IMAGE="${1:-100hellos/bqn:local}"
EXT=".bqn"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
•Out "Args: " ∾ (1↓∾{" "∾𝕩}¨•args)
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
