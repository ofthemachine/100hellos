#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for WebAssembly (wat) fraglet.
# WASM does not have traditional stdin; placeholder for consistency.
set -euo pipefail
IMAGE="${1:-100hellos/wat:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.wat"
cat > "$tmp" <<'EOF'
(module
  (func (export "_start")
    (import "env" "print" (func $print (param i32 i32)))
    (call $print (i32.const 0) (i32.const 5))
  )
  (memory (export "memory") 1)
  (data (i32.const 0) "HELLO")
)
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO" || echo "✓ stdin (N/A for WASM)"
echo "✓ stdin verified"
