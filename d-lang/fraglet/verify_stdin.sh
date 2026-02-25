#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for D fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/d-lang:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.d"
cat > "$tmp" <<'EOF'
import std.stdio;
import std.string;

void main() {
    foreach (line; stdin.byLine) {
        writeln(line.to!string.strip.toUpper);
    }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
