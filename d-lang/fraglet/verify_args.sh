#!/bin/bash
# verify_args.sh - Verified capability: argument passing for D fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/d-lang:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.d"
cat > "$tmp" <<'EOF'
import std.stdio;
import std.array;

void main(string[] args) {
    writeln("Args: ", args[1..].join(" "));
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
