#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Objective-C fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/objective-c:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.m"
cat > "$tmp" <<'EOF'
#import <stdio.h>
int main(int argc, char *argv[]) {
    printf("Args:");
    int i;
    for (i = 1; i < argc; i++)
        printf(" %s", argv[i]);
    printf("\n");
    return 0;
}
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
