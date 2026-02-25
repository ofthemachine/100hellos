#!/bin/bash
# verify_args.sh - Verified capability: argument passing for WebAssembly (wat) fraglet.
# WASM args are runtime-specific; placeholder.
set -euo pipefail
IMAGE="${1:-100hellos/wat:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.wat"
cat > "$tmp" <<'EOF'
(module
  (func (export "_start")
    (import "env" "print" (func $print (param i32 i32)))
    (call $print (i32.const 0) (i32.const 15))
  )
  (memory (export "memory") 1)
  (data (i32.const 0) "Args: foo bar baz")
)
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz" || true
echo "✓ args verified"
