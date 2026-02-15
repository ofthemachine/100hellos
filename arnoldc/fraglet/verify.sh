#!/bin/bash
# verify.sh - Smoke tests for ArnoldC fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/arnoldc:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.arnoldc"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" 2>&1 | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
cat > "$tmp" <<'EOF'
IT'S SHOWTIME
  TALK TO THE HAND "Hello from fragment!"
YOU HAVE BEEN TERMINATED
EOF
verify_fraglet "Hello from fragment!"

# Example 2: Multiple lines
cat > "$tmp" <<'EOF'
IT'S SHOWTIME
  TALK TO THE HAND "Arnold says hello!"
  TALK TO THE HAND "Hasta la vista, baby!"
YOU HAVE BEEN TERMINATED
EOF
verify_fraglet "Arnold says hello!"
verify_fraglet "Hasta la vista"

# Example 3: Math (5 + 10)
cat > "$tmp" <<'EOF'
IT'S SHOWTIME
  HEY CHRISTMAS TREE sum
  YOU SET US UP 0
  GET TO THE CHOPPER sum
  HERE IS MY INVITATION 5
  GET UP 10
  ENOUGH TALK
  TALK TO THE HAND sum
YOU HAVE BEEN TERMINATED
EOF
verify_fraglet "15"

echo "✓ All tests passed"
