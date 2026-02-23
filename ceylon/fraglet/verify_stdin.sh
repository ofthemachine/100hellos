#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Ceylon fraglet.

set -euo pipefail

IMAGE="${1:-100hellos/ceylon:local}"
EXT=".ceylon"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
shared void run() {
    while (exists line = process.readLine()) {
        print(line.uppercased);
    }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -Fq "HELLO"
echo "✓ stdin verified"
