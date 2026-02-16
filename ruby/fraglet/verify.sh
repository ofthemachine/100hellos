#!/bin/bash
# verify.sh - Smoke tests for Ruby fraglet support (base + guide examples).
# Contract: default run, guide examples. Stdin/args in verify_stdin.sh / verify_args.sh.

set -euo pipefail

IMAGE="${1:-100hellos/ruby:local}"
EXT=".rb"
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

# Example 1: Simple output
cat > "$tmp" <<'EOF'
puts "Hello, World!"
EOF
verify_fraglet "Hello, World!"

# Example 2: Method and greet
cat > "$tmp" <<'EOF'
def greet(name)
  "Hello, #{name}!"
end

puts greet("Alice")
EOF
verify_fraglet "Hello, Alice!"

# Example 3: Array processing
cat > "$tmp" <<'EOF'
numbers = [1, 2, 3, 4, 5]
squared = numbers.map { |x| x**2 }
puts "Sum of squares: #{squared.sum}"
EOF
verify_fraglet "Sum of squares"

echo "✓ All tests passed"
