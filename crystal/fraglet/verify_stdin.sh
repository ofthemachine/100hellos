#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Crystal fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/crystal:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.cr"
cat > "$tmp" <<'EOF'
STDIN.each_line do |line|
  puts line.upcase
end
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
