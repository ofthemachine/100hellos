#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Fantom fraglet.
# Contract: fragment reads stdin; pipe into fragletc and assert output.

set -euo pipefail

IMAGE="${1:-100hellos/fantom:local}"
EXT=".fan"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
class Fraglet {
  Void main() {
    in := Env.cur().in
    in.eachLine |line| { echo(line.upper) }
  }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -Fq "HELLO"
echo "✓ stdin verified"
