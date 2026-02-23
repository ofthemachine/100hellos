#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Fantom fraglet.
# Contract: fragment receives args; fragletc passes them through.

set -euo pipefail

IMAGE="${1:-100hellos/fantom:local}"
EXT=".fan"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
class Fraglet {
  Void main() {
    args := Env.cur().args
    echo("Args: " + args.join(" "))
  }
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -Fq "Args: foo bar baz"
echo "✓ args verified"
