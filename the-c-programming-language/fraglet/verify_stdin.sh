#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for C fraglet.
# Contract: fragment reads stdin; pipe into fragletc and assert output.

set -euo pipefail

IMAGE="${1:-100hellos/the-c-programming-language:local}"
EXT=".c"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
#include <stdio.h>
#include <ctype.h>
int main() {
    int c;
    while ((c = getchar()) != EOF) putchar(toupper(c));
    return 0;
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
