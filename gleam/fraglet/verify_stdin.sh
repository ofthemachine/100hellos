#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Gleam fraglet.
# Gleam stdin may require gleam_stdin package; this uses io module if available.
set -euo pipefail
IMAGE="${1:-100hellos/gleam:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.gleam"
cat > "$tmp" <<'EOF'
import gleam/io
import gleam/erlang/process

pub fn main() {
  case io.get_line(process.stdin()) {
    Ok(line) -> io.println(string.uppercase(line))
    Error(_) -> Nil
  }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
