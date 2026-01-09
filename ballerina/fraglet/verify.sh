#!/bin/bash
# verify.sh - Smoke tests for Ballerina fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/ballerina:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello, World!" <<'EOF'
public function main() {
    io:println("Hello, World!");
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
public function main() {
    int a = 5;
    int b = 10;
    io:println("Sum: " + (a + b).toString());
}
EOF

# Example 3: Function definition
verify_fraglet "Hello, Alice" <<'EOF'
function greet(string name) returns string {
    return "Hello, " + name + "!";
}

public function main() {
    io:println(greet("Alice"));
}
EOF

# Example 4: Arrays and loops
verify_fraglet "Array sum:" <<'EOF'
public function main() {
    int[] numbers = [1, 2, 3, 4, 5];
    int sum = 0;
    foreach int n in numbers {
        sum += n;
    }
    io:println("Array sum: " + sum.toString());
}
EOF

# Example 5: Multiple helper functions
verify_fraglet "5 + 3 = 8" <<'EOF'
function add(int a, int b) returns int {
    return a + b;
}

function multiply(int a, int b) returns int {
    return a * b;
}

public function main() {
    io:println("5 + 3 = " + add(5, 3).toString());
    io:println("5 * 3 = " + multiply(5, 3).toString());
}
EOF

echo "✓ All tests passed"
