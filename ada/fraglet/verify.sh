#!/bin/bash
# verify.sh - Smoke tests for Ada fraglet support
# Fragment = procedure body only (injected between begin and end in template).

set -euo pipefail

IMAGE="${1:-100hellos/ada:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.adb"

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
  Put_Line ("Hello from fragment!");
EOF
verify_fraglet "Hello from fragment!"

# Example 2: Variables and calculations
cat > "$tmp" <<'EOF'
  declare
    A : Integer := 5;
    B : Integer := 10;
  begin
    Put_Line ("Sum: " & Integer'Image (A + B));
  end;
EOF
verify_fraglet "Sum:"

# Example 3: Loops
cat > "$tmp" <<'EOF'
  for I in 1..5 loop
    Put_Line ("Count: " & Integer'Image (I));
  end loop;
EOF
verify_fraglet "Count:"

# Example 4: Arrays
cat > "$tmp" <<'EOF'
  declare
    Numbers : array (1..5) of Integer := (1, 2, 3, 4, 5);
    Sum : Integer := 0;
  begin
    for I in Numbers'Range loop
      Sum := Sum + Numbers (I);
    end loop;
    Put_Line ("Array sum: " & Integer'Image (Sum));
  end;
EOF
verify_fraglet "Array sum:"

echo "✓ All tests passed"
