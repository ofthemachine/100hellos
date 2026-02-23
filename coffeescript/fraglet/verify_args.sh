#!/bin/bash
# verify_args.sh - Verified capability: argument passing for CoffeeScript fraglet.
# Contract: fragment receives args; fragletc passes them through.

set -euo pipefail

IMAGE="${1:-100hellos/coffeescript:local}"
EXT="coffee"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
args = process.argv[2..]
console.log "Args: " + args.join " "
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -Fq "Args: foo bar baz"
echo "✓ args verified"
