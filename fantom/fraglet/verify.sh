#!/bin/bash
# verify.sh - Smoke tests for Fantom fraglet support (base + guide examples).
# Contract: default run, guide examples. Stdin/args in verify_stdin.sh / verify_args.sh.

set -euo pipefail

IMAGE="${1:-100hellos/fantom:local}"
EXT=".fan"
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
class Fraglet {
  Void main() {
    echo("Hello, World!")
  }
}
EOF
verify_fraglet "Hello, World!"

# Example 2: Variable and greet
cat > "$tmp" <<'EOF'
class Fraglet {
  Void main() {
    name := "Alice"
    echo("Hello, $name!")
  }
}
EOF
verify_fraglet "Hello, Alice!"

# Example 3: List processing (sum of squares) — manual loop to avoid closure grammar in script
cat > "$tmp" <<'EOF'
class Fraglet {
  Void main() {
    numbers := [1, 2, 3, 4, 5]
    sum := 0
    numbers.each |Int n| { sum += n * n }
    echo("Sum of squares: $sum")
  }
}
EOF
verify_fraglet "Sum of squares"

echo "✓ All tests passed"
