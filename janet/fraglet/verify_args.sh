#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Janet fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/janet:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.janet"
cat > "$tmp" <<'EOF'
(def args (dyn :args))
(printf "Args: %s" (string/join (array/slice args 1) " "))
(print)
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
