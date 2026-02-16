#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Scala fraglet.
# Contract: fragment reads stdin; pipe into fragletc and assert output.

set -euo pipefail

IMAGE="${1:-100hellos/scala:local}"
EXT=".scala"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
object Main {
  def main(args: Array[String]): Unit = {
    scala.io.Source.stdin.getLines().foreach(line => println(line.toUpperCase))
  }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
