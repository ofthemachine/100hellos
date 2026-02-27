#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Groovy fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/groovy:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.groovy"
cat > "$tmp" <<'EOF'
System.in.eachLine { println it.toUpperCase() }
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
