#!/bin/bash
# verify.sh - Smoke tests for mksh fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/mksh:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ksh"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
print "Hello from fragment!"
EOF
verify_fraglet "Hello from fragment!"

cat > "$tmp" <<'EOF'
NAME="Alice"
print "Hello, $NAME!"
EOF
verify_fraglet "Hello, Alice"

cat > "$tmp" <<'EOF'
A=5
B=10
SUM=$((A + B))
print "Sum: $SUM"
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
set -A FRUITS apple banana cherry
for fruit in "${FRUITS[@]}"; do
    print "Fruit: $fruit"
done
EOF
verify_fraglet "Fruit: apple"

cat > "$tmp" <<'EOF'
if [[ "test" == "test" ]]; then
    print "Testing mode"
else
    print "Normal mode"
fi
EOF
verify_fraglet "Testing mode"

cat > "$tmp" <<'EOF'
greet() {
    local name="$1"
    print "Hello, $name!"
}

greet "World"
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
DATE=$(date)
print "Current date: $DATE"
EOF
verify_fraglet "Current date:"

cat > "$tmp" <<'EOF'
for i in 1 2 3 4 5; do
    print "Count: $i"
done
EOF
verify_fraglet "Count: 1"

cat > "$tmp" <<'EOF'
print "First line"
print "Second line"
print "Third line"
EOF
verify_fraglet "First line"

cat > "$tmp" <<'EOF'
if [[ -n "hello" ]]; then
    if [[ "hello" == "hello" ]]; then
        print "Greeting received"
    else
        print "Other argument: hello"
    fi
else
    print "No argument provided"
fi
EOF
verify_fraglet "Greeting received"

echo "✓ All tests passed"
