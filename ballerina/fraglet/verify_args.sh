#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Ballerina fraglet.
# main(string... args) and foreach; execution script runs with "$@".
set -euo pipefail
IMAGE="${1:-100hellos/ballerina:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.bal"
cat > "$tmp" <<'EOF'
public function main(string... args) {
    foreach string arg in args {
        io:println(arg);
    }
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar 2>&1 | grep -q "foo"
echo "✓ args verified"
