#!/bin/bash
# verify.sh - Smoke tests for Fortran fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/fortran:local}"

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
print *, "Hello from fragment!"
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
integer :: a = 5
integer :: b = 10
print *, "Sum:", a + b
EOF

# Example 3: Loops
verify_fraglet "Count:" <<'EOF'
integer :: i
do i = 1, 5
    print *, "Count:", i
end do
EOF

# Example 4: Arrays
verify_fraglet "Array sum:" <<'EOF'
integer, dimension(5) :: numbers = [1, 2, 3, 4, 5]
integer :: sum = 0
integer :: i
do i = 1, 5
    sum = sum + numbers(i)
end do
print *, "Array sum:", sum
EOF

echo "✓ All tests passed"
