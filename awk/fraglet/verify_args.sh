#!/bin/bash
# verify_args.sh - Verified capability: argument passing for AWK fraglet.
# ARGC/ARGV in BEGIN; set ARGC=1 so args are not opened as files.
set -euo pipefail
IMAGE="${1:-100hellos/awk:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.awk"
cat > "$tmp" <<'EOF'
BEGIN {
  for (i = 1; i < ARGC; i++)
    print ARGV[i]
  ARGC = 1
}
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar 2>&1)
echo "$output" | grep -q "foo"
echo "✓ args verified"
