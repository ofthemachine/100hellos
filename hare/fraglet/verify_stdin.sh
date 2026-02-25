#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Hare fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/hare:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ha"
cat > "$tmp" <<'EOF'
use io;
use os;
use strings;

export fn main() void = {
    let buf = io::dynamic();
    defer io::close(buf);
    for (true) {
        match (io::read_line(os::stdin)) {
        case let s: str =>
            defer free(s);
            io::print(strings::toutf8(strings::upper(s)));
            io::println("");
        case io::EOF =>
            break;
        };
    };
};
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
