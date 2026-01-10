#!/bin/bash
# verify.sh - Smoke tests for Ceylon fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/ceylon:local}"

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
shared void run() {
    print("Hello, World!");
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
shared void run() {
    Integer a = 5;
    Integer b = 10;
    Integer sum = a + b;
    print("Sum: ``sum``");
}
EOF

# Example 3: Function definition
verify_fraglet "Hello, Alice" <<'EOF'
String greet(String name) {
    return "Hello, ``name``!";
}

shared void run() {
    print(greet("Alice"));
}
EOF

# Example 4: Arrays and loops
verify_fraglet "Array sum:" <<'EOF'
shared void run() {
    Integer[] numbers = [1, 2, 3, 4, 5];
    variable Integer sum = 0;
    for (n in numbers) {
        sum += n;
    }
    print("Array sum: ``sum``");
}
EOF

# Example 5: Multiple helper functions
verify_fraglet "Result:" <<'EOF'
Integer add(Integer a, Integer b) {
    return a + b;
}

Integer multiply(Integer a, Integer b) {
    return a * b;
}

shared void run() {
    Integer result = multiply(add(2, 3), 4);
    print("Result: ``result``");
}
EOF

# Example 6: String operations
verify_fraglet "Length:" <<'EOF'
shared void run() {
    String text = "Hello, World!";
    print("Length: ``text.size``");
}
EOF

# Example 7: Conditionals
verify_fraglet "Grade: B" <<'EOF'
shared void run() {
    Integer score = 85;
    if (score >= 90) {
        print("Grade: A");
    } else if (score >= 80) {
        print("Grade: B");
    } else {
        print("Grade: C");
    }
}
EOF

# Example 8: Iteration with indices
verify_fraglet "0: apple" <<'EOF'
shared void run() {
    String[] fruits = ["apple", "banana", "cherry"];
    for (i -> fruit in fruits.indexed) {
        print("``i``: ``fruit``");
    }
}
EOF

echo "✓ All tests passed"
