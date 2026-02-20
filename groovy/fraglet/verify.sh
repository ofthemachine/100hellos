#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/groovy:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.groovy"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -Fq "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -Fq "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
println "Hello, World!"
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
def greet(name) {
    "Hello, ${name}!"
}

println greet("Alice")
EOF
verify_fraglet "Hello, Alice!"

cat > "$tmp" <<'EOF'
def numbers = [1, 2, 3, 4, 5]
def squared = numbers.collect { it * it }
println "Sum of squares: ${squared.sum()}"
EOF
verify_fraglet "Sum of squares:"

cat > "$tmp" <<'EOF'
def multiply = { a, b -> a * b }
println "5 * 3 = ${multiply(5, 3)}"
EOF
verify_fraglet "5 * 3 = 15"

cat > "$tmp" <<'EOF'
class Calculator {
    def add(a, b) {
        a + b
    }
}

def calc = new Calculator()
println "10 + 20 = ${calc.add(10, 20)}"
EOF
verify_fraglet "10 + 20 = 30"

cat > "$tmp" <<'EOF'
def name = "Groovy"
def version = 4
println "Welcome to ${name} ${version}!"
EOF
verify_fraglet "Welcome to Groovy"

cat > "$tmp" <<'EOF'
def person = [name: "Bob", age: 30]
println "${person.name} is ${person.age} years old"
EOF
verify_fraglet "Bob is 30 years old"

echo "✓ All tests passed"
