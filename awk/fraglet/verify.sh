#!/bin/bash
# verify.sh - Smoke tests for AWK fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/awk:local}"
EXT=".awk"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Simple output
cat > "$tmp" <<'EOF'
BEGIN {
  print "Hello, World!"
}
EOF
verify_fraglet "Hello, World!"

# Variable assignment
cat > "$tmp" <<'EOF'
BEGIN {
  name = "Alice"
  print "Hello, " name "!"
}
EOF
verify_fraglet "Hello, Alice"

# Array processing (sum of squares)
cat > "$tmp" <<'EOF'
BEGIN {
  numbers[1] = 1
  numbers[2] = 2
  numbers[3] = 3
  numbers[4] = 4
  numbers[5] = 5
  sum = 0
  for (i in numbers) {
    sum += numbers[i] * numbers[i]
  }
  print "Sum of squares: " sum
}
EOF
verify_fraglet "Sum of squares: 55"

echo "✓ All tests passed"
