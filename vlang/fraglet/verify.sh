#!/bin/bash
# verify.sh - Smoke tests for vlang fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/vlang:local}"

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
fn main() {
    println('Hello from fragment!')
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
fn main() {
    a := 5
    b := 10
    println('Sum: ${a + b}')
}
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(5, 10)
    println('5 + 10 = ${result}')
}
EOF

# Example 4: Arrays and loops
verify_fraglet "Sum: 15" <<'EOF'
fn main() {
    numbers := [1, 2, 3, 4, 5]
    mut sum := 0
    for num in numbers {
        sum += num
    }
    println('Sum: ${sum}')
}
EOF

# Example 5: Structs and methods
verify_fraglet "Alice is 30 years old" <<'EOF'
struct Person {
    name string
    age  int
}

fn (p Person) greet() {
    println('${p.name} is ${p.age} years old')
}

fn main() {
    p := Person{name: 'Alice', age: 30}
    p.greet()
}
EOF

# Example 6: Maps
verify_fraglet "Apples: 5" <<'EOF'
fn main() {
    mut m := map[string]int{}
    m['apple'] = 5
    m['banana'] = 3
    println('Apples: ${m['apple']}')
}
EOF

# Example 7: String operations
verify_fraglet "Hello World!" <<'EOF'
fn main() {
    mut s := 'Hello'
    s += ' World!'
    println(s)
}
EOF

# Example 8: Mutable variables
verify_fraglet "x = 20" <<'EOF'
fn main() {
    mut x := 10
    x = 20
    println('x = ${x}')
}
EOF

echo "✓ All tests passed"
