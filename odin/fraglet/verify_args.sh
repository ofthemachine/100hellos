#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Odin fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/odin:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.odin"
cat > "$tmp" <<'EOF'
import "core:fmt"
import "core:os"
import "core:strings"

main :: proc() {
    args := os.args[1:]
    fmt.println("Args:", strings.join(args, " "))
}
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
