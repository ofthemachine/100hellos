#!/bin/bash
# verify_args.sh - Verified capability: argument passing for SML fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/sml:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.sml"
cat > "$tmp" <<'EOF'
val allArgs = CommandLine.arguments ();
val args = List.drop (allArgs, 3);
print ("Args: " ^ String.concatWith " " args ^ "\n");
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
