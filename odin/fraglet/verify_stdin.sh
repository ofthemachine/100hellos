#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Odin fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/odin:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.odin"
cat > "$tmp" <<'EOF'
import "core:fmt"
import "core:os"
import "core:strings"

main :: proc() {
    buf: [4096]u8
    for {
        n, err := os.read(os.stdin, buf[:])
        if err != nil || n == 0 { break }
        line := string(buf[:n])
        fmt.print(strings.to_upper(line))
    }
}
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
