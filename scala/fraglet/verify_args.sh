#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Scala fraglet.
# Contract: fragment receives args; fragletc passes them through.

set -euo pipefail

IMAGE="${1:-100hellos/scala:local}"
EXT=".scala"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
object Main {
  def main(args: Array[String]): Unit = {
    println("Args: " + args.mkString(" "))
  }
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
