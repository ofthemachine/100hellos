#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Janet fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/janet:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.janet"
cat > "$tmp" <<'EOF'
(print "Args:" (string/join (dyn :args) " "))
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
