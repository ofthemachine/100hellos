#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/groovy:local}"

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -Fq "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Hello, World!"
println "Hello, World!"
EOF

# Example 2: Method definition
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Hello, Alice!"
def greet(name) {
    "Hello, ${name}!"
}

println greet("Alice")
EOF

# Example 3: List processing
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Sum of squares:"
def numbers = [1, 2, 3, 4, 5]
def squared = numbers.collect { it * it }
println "Sum of squares: ${squared.sum()}"
EOF

# Example 4: Closure usage
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "5 * 3 = 15"
def multiply = { a, b -> a * b }
println "5 * 3 = ${multiply(5, 3)}"
EOF

# Example 5: Class definition
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "10 + 20 = 30"
class Calculator {
    def add(a, b) {
        a + b
    }
}

def calc = new Calculator()
println "10 + 20 = ${calc.add(10, 20)}"
EOF

# Example 6: String interpolation
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Welcome to Groovy 4!"
def name = "Groovy"
def version = 4
println "Welcome to ${name} ${version}!"
EOF

# Example 7: Map operations
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Bob is 30 years old"
def person = [name: "Bob", age: 30]
println "${person.name} is ${person.age} years old"
EOF

echo "✓ All tests passed"
