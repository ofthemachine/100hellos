#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/elixir:local}"
EXT=".exs"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
input = IO.read(:stdio, :all)
IO.puts(String.upcase(String.trim(input)))
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
