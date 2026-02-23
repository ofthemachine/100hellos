#!/bin/bash
# verify.sh - Smoke tests for CoffeeScript fraglet support (base + guide examples).
# Contract: default run, guide examples. Stdin/args in verify_stdin.sh / verify_args.sh.

set -euo pipefail

IMAGE="${1:-100hellos/coffeescript:local}"
EXT="coffee"
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
console.log "Hello, World!"
EOF
verify_fraglet "Hello, World!"

# Example 2: Function and greet (multiline)
cat > "$tmp" <<'EOF'
greet = (name) ->
  "Hello, #{name}!"

console.log greet "Alice"
EOF
verify_fraglet "Hello, Alice!"

# Example 3: Loop and aggregation (multiline)
cat > "$tmp" <<'EOF'
numbers = [1, 2, 3, 4, 5]
squared = (x * x for x in numbers)
sum = squared.reduce (a, b) -> a + b
console.log "Sum of squares: #{sum}"
EOF
verify_fraglet "Sum of squares"

echo "✓ All tests passed"
