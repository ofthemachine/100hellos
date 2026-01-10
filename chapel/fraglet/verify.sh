#!/bin/bash
# verify.sh - Smoke tests for Chapel fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/chapel:local}"

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
proc main() {
    writeln("Hello from fragment!");
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
proc main() {
    var a = 5;
    var b = 10;
    writeln("Sum: ", a + b);
}
EOF

# Example 3: Procedure definition
verify_fraglet "Hello, Alice" <<'EOF'
proc greet(name: string) {
    writeln("Hello, ", name, "!");
}

proc main() {
    greet("Alice");
}
EOF

# Example 4: Parallel iteration
verify_fraglet "Count:" <<'EOF'
proc main() {
    forall i in 1..5 do
        writeln("Count: ", i);
}
EOF

# Example 5: Arrays and reductions
verify_fraglet "Array sum:" <<'EOF'
proc main() {
    var numbers: [1..5] int = [1, 2, 3, 4, 5];
    var sum = + reduce numbers;
    writeln("Array sum: ", sum);
}
EOF

# Example 6: Concurrent tasks
verify_fraglet "Task" <<'EOF'
proc main() {
    cobegin {
        writeln("Task 1");
        writeln("Task 2");
    }
}
EOF

# Example 7: Domain and array operations
verify_fraglet "Matrix" <<'EOF'
proc main() {
    const D = {1..3, 1..3};
    var matrix: [D] int;
    forall (i, j) in D do
        matrix[i, j] = i * j;
    writeln("Matrix[2,2] = ", matrix[2, 2]);
}
EOF

# Example 8: Multiple helper procedures
verify_fraglet "5 + 3 = 8" <<'EOF'
proc add(a: int, b: int): int {
    return a + b;
}

proc multiply(a: int, b: int): int {
    return a * b;
}

proc main() {
    writeln("5 + 3 = ", add(5, 3));
    writeln("5 * 3 = ", multiply(5, 3));
}
EOF

echo "✓ All tests passed"
