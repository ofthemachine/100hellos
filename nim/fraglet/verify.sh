#!/bin/bash
# verify.sh - Smoke tests for Nim fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/nim:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.nim"

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
import std/strformat
let a = 5
let b = 10
echo fmt"Sum: {a + b}"
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
import std/strformat
proc add(a, b: int): int =
  return a + b

echo fmt"{5} + {10} = {add(5, 10)}"
EOF
verify_fraglet "5 + 10 = 15"

cat > "$tmp" <<'EOF'
import std/strformat
let numbers = @[1, 2, 3, 4, 5]
var sum = 0
for num in numbers:
  sum += num
echo fmt"Sum: {sum}"
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
let s = "Hello"
let result = s & " World!"
echo result
EOF
verify_fraglet "Hello World!"

cat > "$tmp" <<'EOF'
let x = 10
if x > 5:
  echo "x is greater than 5"
else:
  echo "x is not greater than 5"
EOF
verify_fraglet "x is greater than 5"

cat > "$tmp" <<'EOF'
import std/strformat
var counter = 0
counter += 1
echo fmt"Counter: {counter}"
EOF
verify_fraglet "Counter: 1"

echo "✓ All tests passed"
