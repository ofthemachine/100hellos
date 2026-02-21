#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Perl fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/perl:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.pl"
cat > "$tmp" <<'EOF'
while (<STDIN>) { print uc($_); }
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
