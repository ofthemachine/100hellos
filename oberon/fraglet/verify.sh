#!/bin/bash
# verify.sh - Smoke tests for Oberon fraglet support (base + guide examples).
# Contract: default run, guide examples. Stdin/args only if verify_stdin.sh / verify_args.sh exist.

set -euo pipefail

IMAGE="${1:-100hellos/oberon:local}"
EXT=".mod"
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
MODULE Fraglet;
  IMPORT Out;
BEGIN
  Out.String("Hello, World!");
  Out.Ln
END Fraglet.
EOF
verify_fraglet "Hello, World!"

# Example 2: Variables and calculations
cat > "$tmp" <<'EOF'
MODULE Fraglet;
  IMPORT Out;
  VAR a, b: INTEGER;
BEGIN
  a := 5;
  b := 10;
  Out.String("Sum: ");
  Out.Int(a + b, 0);
  Out.Ln
END Fraglet.
EOF
verify_fraglet "Sum: 15"

# Example 3: Loop
cat > "$tmp" <<'EOF'
MODULE Fraglet;
  IMPORT Out;
  VAR sum, i: INTEGER;
BEGIN
  sum := 0;
  i := 1;
  WHILE i <= 5 DO
    sum := sum + i;
    i := i + 1
  END;
  Out.String("Sum 1..5: ");
  Out.Int(sum, 0);
  Out.Ln
END Fraglet.
EOF
verify_fraglet "Sum 1..5: 15"

# Example 4: Procedure
cat > "$tmp" <<'EOF'
MODULE Fraglet;
  IMPORT Out;
  PROCEDURE Double(x: INTEGER): INTEGER;
  BEGIN
    RETURN x * 2
  END Double;
BEGIN
  Out.String("5 * 2 = ");
  Out.Int(Double(5), 0);
  Out.Ln
END Fraglet.
EOF
verify_fraglet "5 * 2 = 10"

echo "✓ All tests passed"
