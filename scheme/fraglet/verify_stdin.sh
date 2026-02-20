#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Scheme fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/scheme:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.scm"
# Chibi Scheme: (chibi) for display/newline, (scheme base) for read-line, (chibi string) for string-upcase-ascii
cat > "$tmp" <<'EOF'
(import (chibi))
(import (scheme base))
(import (chibi string))
(let loop ((line (read-line)))
  (when (not (eof-object? line))
    (display (string-upcase-ascii line))
    (newline)
    (loop (read-line))))
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
