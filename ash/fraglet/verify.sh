#!/bin/bash
# verify.sh - Smoke tests for ash fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/ash:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ash"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
echo "Hello from fragment!"
EOF
verify_fraglet "Hello from fragment!"

cat > "$tmp" <<'EOF'
NAME="Alice"
echo "Hello, $NAME!"
EOF
verify_fraglet "Hello, Alice"

cat > "$tmp" <<'EOF'
A=5
B=10
SUM=$((A + B))
echo "Sum: $SUM"
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
for i in 1 2 3 4 5; do
    echo "Count: $i"
done
EOF
verify_fraglet "Count:"

cat > "$tmp" <<'EOF'
if [ "test" = "test" ]; then
    echo "Testing mode"
else
    echo "Normal mode"
fi
EOF
verify_fraglet "Testing mode"

echo "✓ All tests passed"
