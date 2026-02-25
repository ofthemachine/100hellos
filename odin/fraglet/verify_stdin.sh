#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Odin fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/odin:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.odin"
cat > "$tmp" <<'EOF'
package main

import "core:fmt"
import "core:os"
import "core:strings"

main :: proc() {
    buf: [256]u8
    for {
        n, ok := os.read(os.stdin, buf[:])
        if !ok || n == 0 do break
        s := strings.to_string(buf[:n])
        fmt.println(strings.to_upper(s))
    }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
