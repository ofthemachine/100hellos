#!/bin/bash
# verify.sh - Smoke tests for Smalltalk fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/smalltalk:local}"
EXT=".st"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -Fq "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -Fq "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
cat > "$tmp" <<'EOF'
'Hello, World!' displayNl
EOF
verify_fraglet "Hello, World!"

# Example 2: Class and greet
cat > "$tmp" <<'EOF'
Object subclass: Greeter [
  greet: name [
    ('Hello, ', name, '!') displayNl
  ]
].
(Greeter new) greet: 'Alice'.
EOF
verify_fraglet "Hello, Alice!"

# Example 3: Sum of squares
cat > "$tmp" <<'EOF'
| numbers squared sum |
numbers := #(1 2 3 4 5).
squared := numbers collect: [ :x | x * x ].
sum := squared inject: 0 into: [ :a :b | a + b ].
('Sum of squares: ', sum printString) displayNl
EOF
verify_fraglet "Sum of squares: 55"

echo "✓ All tests passed"
