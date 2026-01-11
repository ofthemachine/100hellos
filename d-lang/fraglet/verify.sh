#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/d-lang:local}"

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
void main() {
    writeln("Hello from fragment!");
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
void main() {
    int a = 5;
    int b = 10;
    writeln("Sum: ", a + b);
}
EOF

# Example 3: Arrays and ranges
verify_fraglet "Array sum: 15" <<'EOF'
void main() {
    int[] numbers = [1, 2, 3, 4, 5];
    int sum = 0;
    foreach (num; numbers) {
        sum += num;
    }
    writeln("Array sum: ", sum);
}
EOF

# Example 4: String operations
verify_fraglet "Hello World!" <<'EOF'
void main() {
    string message = "Hello";
    message ~= " World!";
    writeln(message);
}
EOF

# Example 5: Simple class
verify_fraglet "5 + 3 = 8" <<'EOF'
class Calculator {
    int add(int a, int b) {
        return a + b;
    }
}

void main() {
    auto calc = new Calculator();
    writeln("5 + 3 = ", calc.add(5, 3));
}
EOF

# Example 6: Template function
verify_fraglet "Max(5, 10) = 10" <<'EOF'
T maximum(T)(T a, T b) {
    return (a > b) ? a : b;
}

void main() {
    writeln("Max(5, 10) = ", maximum(5, 10));
    writeln("Max(3.14, 2.71) = ", maximum(3.14, 2.71));
}
EOF

echo "✓ All tests passed"
