#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Gleam fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/gleam:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.gleam"
cat > "$tmp" <<'EOF'
import gleam/io
import gleam/erlang/process

pub fn main() {
  let args = process.arguments()
  io.println(string.append("Args: ", string.join(args, " ")))
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
