#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Chapel fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/chapel:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.chpl"
cat > "$tmp" <<'EOF'
proc main() {
    var line: string;
    while readln(line) {
        writeln(line.toUpper());
    }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
