#!/bin/bash
# verify.sh - Smoke tests for dash fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/dash:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.dash"

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
verify_fraglet "Count: 1"

cat > "$tmp" <<'EOF'
if [ "test" = "test" ]; then
    echo "Testing mode"
else
    echo "Normal mode"
fi
EOF
verify_fraglet "Testing mode"

cat > "$tmp" <<'EOF'
greet() {
    local name="$1"
    echo "Hello, $name!"
}

greet "World"
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
DATE=$(date)
echo "Current date: $DATE"
EOF
verify_fraglet "Current date:"

cat > "$tmp" <<'EOF'
echo "First line"
echo "Second line"
echo "Third line"
EOF
verify_fraglet "First line"

cat > "$tmp" <<'EOF'
for i in $(seq 1 5); do
    echo "Number: $i"
done
EOF
verify_fraglet "Number: 1"

cat > "$tmp" <<'EOF'
if [ -n "hello" ]; then
    if [ "hello" = "hello" ]; then
        echo "Greeting received"
    else
        echo "Other argument: hello"
    fi
else
    echo "No argument provided"
fi
EOF
verify_fraglet "Greeting received"

echo "✓ All tests passed"
