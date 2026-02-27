#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Vala fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/vala:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.vala"
cat > "$tmp" <<'EOF'
void main () {
    string? line;
    while ((line = stdin.read_line()) != null) {
        print(line.up() + "\n");
    }
}
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
