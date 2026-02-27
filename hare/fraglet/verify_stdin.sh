#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Hare fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/hare:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ha"
cat > "$tmp" <<'EOF'
use fmt;
use os;
use io;
use bufio;
use ascii;

export fn main() void = {
    const scan = bufio::newscanner(os::stdin, 4096);
    defer bufio::finish(&scan);
    for (true) {
        match (bufio::scan_line(&scan)) {
        case let line: const str =>
            const upper = ascii::strupper(line);
            fmt::println(upper as str)!;
            free(upper as str);
        case io::EOF =>
            break;
        case let err: io::error =>
            break;
        };
    };
};
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
