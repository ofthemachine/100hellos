#!/bin/bash
# verify.sh - Smoke tests for Ada fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/ada:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello from fragment!" <<'EOF'
Put_Line ("Hello from fragment!");
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
declare
  A : Integer := 5;
  B : Integer := 10;
begin
  Put_Line ("Sum: " & Integer'Image (A + B));
end;
EOF

# Example 3: Loops
verify_fraglet "Count:" <<'EOF'
for I in 1..5 loop
    Put_Line ("Count: " & Integer'Image (I));
end loop;
EOF

# Example 4: Arrays
verify_fraglet "Array sum:" <<'EOF'
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

echo "✓ All tests passed"
