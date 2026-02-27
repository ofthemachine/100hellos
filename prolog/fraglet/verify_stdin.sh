#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/prolog:local}"
EXT=".pl"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
:- read_line_to_string(user_input, Line),
   upcase_atom(Line, Upper),
   write(Upper), nl.
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
