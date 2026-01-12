#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/wren:local}"

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
System.print("Hello, World!")
EOF

# Example 2: Class definition
verify_fraglet "Hello, Alice!" <<'EOF'
class Person {
  construct new(name) {
    _name = name
  }

  greet {
    System.print("Hello, %(_name)!")
  }
}

var person = Person.new("Alice")
person.greet
EOF

# Example 3: List processing
verify_fraglet "Sum: 15" <<'EOF'
var numbers = [1, 2, 3, 4, 5]
var sum = 0
for (number in numbers) {
  sum = sum + number
}
System.print("Sum: %(sum)")
EOF

# Example 4: Map operations
verify_fraglet "Apples: 5" <<'EOF'
var fruits = {
  "apple": 5,
  "banana": 3
}
System.print("Apples: %(fruits["apple"])")
EOF

# Example 5: String interpolation
verify_fraglet "Hello, World!" <<'EOF'
var name = "World"
System.print("Hello, %(name)!")
EOF

# Example 6: Function-like methods
verify_fraglet "5 + 10 = 15" <<'EOF'
class Calculator {
  static add(a, b) { a + b }
  static multiply(a, b) { a * b }
}

System.print("5 + 10 = %(Calculator.add(5, 10))")
EOF

echo "✓ All tests passed"
