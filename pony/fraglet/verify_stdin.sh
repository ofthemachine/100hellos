#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Pony fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/pony:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.pony"
cat > "$tmp" <<'EOF'
actor Main
  new create(env: Env) =>
    env.input(object iso is InputNotify
      let _out: OutStream = env.out
      fun ref apply(data: Array[U8] iso) =>
        let s = String.from_array(consume data)
        _out.print(s.upper())
      fun ref dispose() => None
    end, 1024)
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
