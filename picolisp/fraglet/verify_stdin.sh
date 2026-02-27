#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Picolisp fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/picolisp:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.l"
cat > "$tmp" <<'EOF'
(in NIL
   (until (eof)
      (prinl (uppc (line T)))))
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
