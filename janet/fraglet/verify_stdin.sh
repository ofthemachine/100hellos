#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Janet fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/janet:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.janet"
cat > "$tmp" <<'EOF'
(while true
  (def line (os/read-line 0))
  (when (nil? line) (break))
  (print (string/ascii-upper line)))
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
