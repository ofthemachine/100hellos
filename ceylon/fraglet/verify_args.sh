#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Ceylon fraglet.

set -euo pipefail

IMAGE="${1:-100hellos/ceylon:local}"
EXT=".ceylon"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
shared void run() {
    print("Args: ``" ".join(process.arguments)``");
}
EOF
# Runner may pass "--" before args; accept either "Args: foo bar baz" or "Args: -- foo bar baz"
out=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$out" | grep -Fq "Args:" && echo "$out" | grep -Fq "foo bar baz"
echo "✓ args verified"
