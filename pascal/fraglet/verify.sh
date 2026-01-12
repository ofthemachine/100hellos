#!/bin/bash
# verify.sh - Smoke tests for Pascal fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/pascal:local}"

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
begin
  writeln('Hello from fragment!');
end.
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
var
  a, b: integer;
begin
  a := 5;
  b := 10;
  writeln('Sum: ', a + b);
end.
EOF

# Example 3: Loops
verify_fraglet "Count:" <<'EOF'
var
  i: integer;
begin
  for i := 1 to 5 do
    writeln('Count: ', i);
end.
EOF

# Example 4: Arrays
verify_fraglet "Array sum:" <<'EOF'
var
  numbers: array[1..5] of integer = (1, 2, 3, 4, 5);
  sum, i: integer;
begin
  sum := 0;
  for i := 1 to 5 do
    sum := sum + numbers[i];
  writeln('Array sum: ', sum);
end.
EOF

echo "✓ All tests passed"
