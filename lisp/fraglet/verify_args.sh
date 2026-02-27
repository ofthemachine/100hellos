#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/lisp:local}"
EXT=".el"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
(format t "Args: ~{~a~^ ~}~%" (cdr sb-ext:*posix-argv*))
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
