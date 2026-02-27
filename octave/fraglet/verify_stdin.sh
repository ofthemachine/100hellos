#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/octave:local}"
EXT=".m"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
line = fgetl(stdin);
printf("%s\n", toupper(line));
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
