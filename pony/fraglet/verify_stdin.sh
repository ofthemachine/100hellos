#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Pony fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/pony:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.pony"
cat > "$tmp" <<'EOF'
use "format"

actor Main
  new create(env: Env) =>
    try
      while true do
        let line = env.input.line()?
        env.out.print(line.upper())
      end
    end
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
