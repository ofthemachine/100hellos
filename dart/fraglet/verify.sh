#!/bin/bash
# verify.sh - Smoke tests for Dart fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/dart:local}"

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
print("Hello, World!");
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
var a = 5;
var b = 10;
print("Sum: ${a + b}");
EOF

# Example 3: Function definition
verify_fraglet "Hello, Alice" <<'EOF'
String greet(String name) {
  return "Hello, $name!";
}
print(greet("Alice"));
EOF

# Example 4: List processing
verify_fraglet "Sum of squares:" <<'EOF'
var numbers = [1, 2, 3, 4, 5];
var squared = numbers.map((x) => x * x).toList();
var sum = squared.reduce((a, b) => a + b);
print("Sum of squares: $sum");
EOF

# Example 5: Loops
verify_fraglet "Count:" <<'EOF'
for (var i = 1; i <= 5; i++) {
  print("Count: $i");
}
EOF

# Example 6: Maps
verify_fraglet "Bob is 30 years old" <<'EOF'
var person = {"name": "Bob", "age": 30};
print("${person["name"]} is ${person["age"]} years old");
EOF

echo "✓ All tests passed"
