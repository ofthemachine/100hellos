#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Scheme fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/scheme:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.scm"
# Chibi Scheme: full script; (chibi) for display/newline, (scheme process-context) for command-line, (chibi string) for string-join
cat > "$tmp" <<'EOF'
(import (chibi))
(import (scheme process-context))
(import (chibi string))
(display "Args: ")
(display (string-join (cdr (command-line)) " "))
(newline)
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
