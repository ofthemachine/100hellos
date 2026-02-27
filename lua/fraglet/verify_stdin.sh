#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/lua:local}"
EXT=".lua"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
for line in io.lines() do
    print(string.upper(line))
end
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
