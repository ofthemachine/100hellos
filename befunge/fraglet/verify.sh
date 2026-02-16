#!/bin/bash
# verify.sh - Smoke tests for Befunge-93 fraglet support (whole-file replacement).

set -euo pipefail

IMAGE="${1:-100hellos/befunge:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.bf"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" 2>&1 | grep -q "Hello World!"

echo "Testing fraglet (Hello World program)..."
# Same program as default hello-world.bf
cat > "$tmp" <<'EOF'
64+"!dlroW olleH">:v
                 ^,_@
EOF
verify_fraglet "Hello World!"

echo "✓ All tests passed"
