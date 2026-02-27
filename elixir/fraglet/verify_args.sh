#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/elixir:local}"
EXT=".exs"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
args = System.argv()
puts("Args: #{Enum.join(args, " ")}")
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
