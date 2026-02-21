#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Perl fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/perl:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.pl"
cat > "$tmp" <<'EOF'
print "Args: " . join(" ", @ARGV) . "\n";
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
