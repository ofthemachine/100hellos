#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/forth:local}"
EXT=".fth"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
: main
  ." Args:"
  begin next-arg dup while
    space type
  repeat 2drop cr ;
main bye
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
