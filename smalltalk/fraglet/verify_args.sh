#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Smalltalk fraglet.

set -euo pipefail

IMAGE="${1:-100hellos/smalltalk:local}"
EXT=".st"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
'Args: ' display. ((Smalltalk arguments) inject: '' into: [:acc :arg | (acc = '') ifTrue: [arg] ifFalse: [acc, ' ', arg]]) displayNl
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -Fq "Args: foo bar baz"
echo "✓ args verified"
