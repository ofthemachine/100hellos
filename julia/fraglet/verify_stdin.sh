#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/julia:local}"
EXT=".jl"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
for line in eachline(stdin)
    println(uppercase(line))
end
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
