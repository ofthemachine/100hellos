#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/lisp:local}"
EXT=".el"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
(loop for line = (read-line *standard-input* nil)
      while line
      do (format t "~A~%" (string-upcase line)))
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
