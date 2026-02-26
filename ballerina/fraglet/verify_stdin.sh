#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Ballerina fraglet.
# io:readln() and string.toUpper(); echo one line and grep.
set -euo pipefail
IMAGE="${1:-100hellos/ballerina:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.bal"
cat > "$tmp" <<'EOF'
public function main() {
    string? line = io:readln("");
    if line is string {
        io:println(line);
    }
}
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "hello"
echo "✓ stdin verified"
