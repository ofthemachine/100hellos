#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Tcl fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/tcl:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.tcl"
cat > "$tmp" <<'EOF'
puts "Args: [join $argv " "]"
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
