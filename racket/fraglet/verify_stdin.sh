#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Racket fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/racket:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.rkt"
cat > "$tmp" <<'EOF'
(for ([line (in-lines)])
  (displayln (string-upcase line)))
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
