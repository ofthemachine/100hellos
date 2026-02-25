#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Picolisp fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/picolisp:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.l"
cat > "$tmp" <<'EOF'
(loop
  (when (eof (rd))
    (bye))
  (prinl (uppc (line (rd)))) )
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
