#!/bin/bash
# verify_args.sh - Verified capability: argument passing for C fraglet.
# Contract: fragment receives args; fragletc passes them through.

set -euo pipefail

IMAGE="${1:-100hellos/the-c-programming-language:local}"
EXT=".c"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
#include <stdio.h>
int main(int argc, char *argv[]) {
    if (argc > 1) printf("First: %s\n", argv[1]);
    if (argc > 2) printf("Second: %s\n", argv[2]);
    return 0;
}
EOF
output=$(fragletc --image "$IMAGE" "$tmp" arg1 arg2 2>&1)
echo "$output" | grep -q "First: arg1"
echo "✓ args verified"
