#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Objective-C fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/objective-c:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.m"
cat > "$tmp" <<'EOF'
#import <Foundation/Foundation.h>
#import <stdio.h>
int main(int argc, char *argv[]) {
    char *line = NULL;
    size_t n = 0;
    while (getline(&line, &n, stdin) != -1) {
        NSString *s = [NSString stringWithUTF8String:line];
        printf("%s\n", [[s uppercaseString] UTF8String]);
    }
    return 0;
}
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
