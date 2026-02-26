#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Vala fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/vala:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.vala"
cat > "$tmp" <<'EOF'
using Posix;

void main() {
    var stdin = FileStream.stdin;
    string? line;
    while ((line = stdin.read_line()) != null) {
        print(line.up().to_string() + "\n");
    }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
