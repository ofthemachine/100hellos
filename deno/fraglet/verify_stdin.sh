#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Deno fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/deno:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ts"
cat > "$tmp" <<'EOF'
const buf = new Uint8Array(1024);
while (true) {
  const n = await Deno.stdin.read(buf);
  if (n === null) break;
  const s = new TextDecoder().decode(buf.subarray(0, n));
  console.log(s.trim().toUpperCase());
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
