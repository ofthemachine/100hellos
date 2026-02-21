#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Racket fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/racket:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.rkt"
cat > "$tmp" <<'EOF'
(require racket/string)
(display "Args: ")
(displayln (string-join (vector->list (current-command-line-arguments)) " "))
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
