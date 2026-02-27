#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Io fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/io:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.io"
cat > "$tmp" <<'EOF'
write("Args:")
System args rest foreach(arg, write(" " .. arg))
writeln
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
