#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/r-project:local}"
EXT=".r"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
input <- readLines(con = "stdin")
cat(toupper(input), "\n")
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
