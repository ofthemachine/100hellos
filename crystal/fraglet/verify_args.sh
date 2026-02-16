#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Crystal fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/crystal:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.cr"
cat > "$tmp" <<'EOF'
puts "Args: #{ARGV.join(" ")}"
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
