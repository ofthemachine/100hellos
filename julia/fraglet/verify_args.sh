#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/julia:local}"
EXT=".jl"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
println("Args: " * join(ARGS, " "))
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
