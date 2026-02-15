#!/bin/bash
# verify_args.sh - Verified capability: argument passing for APL (GNU APL) fraglet.
# ⎕ARG gets options after --; entrypoint passes script args to apl -- "$@".
set -euo pipefail
IMAGE="${1:-100hellos/apl:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.apl"
cat > "$tmp" <<'EOF'
(⎕ARG ⍳ ⊂'--') ↓ ⎕ARG
EOF
fragletc --image "$IMAGE" "$tmp" "foo" 2>&1 | grep -q "foo"
echo "✓ args verified"
