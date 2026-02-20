#!/bin/bash
# verify.sh - Smoke tests for tcsh fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/tcsh:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.tcsh"

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
set NAME="Alice"
echo "Hello, $NAME!"
EOF
verify_fraglet "Hello, Alice"

cat > "$tmp" <<'EOF'
@ A = 5
@ B = 10
@ SUM = $A + $B
echo "Sum: $SUM"
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
set FRUITS=(apple banana cherry)
foreach fruit ($FRUITS)
    echo "Fruit: $fruit"
end
EOF
verify_fraglet "Fruit: apple"

cat > "$tmp" <<'EOF'
if ("test" == "test") then
    echo "Testing mode"
else
    echo "Normal mode"
endif
EOF
verify_fraglet "Testing mode"

cat > "$tmp" <<'EOF'
@ i = 1
while ($i <= 5)
    echo "Count: $i"
    @ i++
end
EOF
verify_fraglet "Count: 5"

cat > "$tmp" <<'EOF'
set DATE=`date`
echo "Current date: $DATE"
EOF
verify_fraglet "Current date:"

cat > "$tmp" <<'EOF'
set ARRAY=(one two three)
echo "First: $ARRAY[1]"
EOF
verify_fraglet "First: one"

echo "✓ All tests passed"
