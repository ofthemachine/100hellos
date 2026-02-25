#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Io fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/io:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.io"
cat > "$tmp" <<'EOF'
loop(
  line := File standardInput readLine
  if(line isNil, break)
  line asUppercase println
)
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
