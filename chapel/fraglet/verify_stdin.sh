#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Chapel fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/chapel:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.chpl"
cat > "$tmp" <<'EOF'
use IO;
proc main() {
    var line: string;
    while stdin.readLine(line) {
        write(line.toUpper());
    }
}
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
