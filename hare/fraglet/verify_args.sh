#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Hare fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/hare:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ha"
cat > "$tmp" <<'EOF'
use fmt;
use os;
use strings;

export fn main() void = {
    let args = os::args[1..];
    fmt::print("Args: ")!;
    for (let i = 0z; i < len(args); i += 1) {
        if (i > 0) fmt::print(" ")!;
        fmt::print(args[i])!;
    };
    fmt::println("")!;
};
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
