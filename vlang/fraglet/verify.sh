#!/bin/bash
# verify.sh - Smoke tests for vlang fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/vlang:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.v"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" 2>&1 | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
fn main() {
    println('Hello from fragment!')
}
EOF
verify_fraglet "Hello from fragment!"

cat > "$tmp" <<'EOF'
fn main() {
    a := 5
    b := 10
    println('Sum: ${a + b}')
}
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
fn add(a int, b int) int {
    return a + b
}

fn main() {
    result := add(5, 10)
    println('5 + 10 = ${result}')
}
EOF
verify_fraglet "5 + 10 = 15"

cat > "$tmp" <<'EOF'
fn main() {
    numbers := [1, 2, 3, 4, 5]
    mut sum := 0
    for num in numbers {
        sum += num
    }
    println('Sum: ${sum}')
}
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
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
verify_fraglet "Alice is 30 years old"

cat > "$tmp" <<'EOF'
fn main() {
    mut m := map[string]int{}
    m['apple'] = 5
    m['banana'] = 3
    println('Apples: ${m['apple']}')
}
EOF
verify_fraglet "Apples: 5"

cat > "$tmp" <<'EOF'
fn main() {
    mut s := 'Hello'
    s += ' World!'
    println(s)
}
EOF
verify_fraglet "Hello World!"

cat > "$tmp" <<'EOF'
fn main() {
    mut x := 10
    x = 20
    println('x = ${x}')
}
EOF
verify_fraglet "x = 20"

echo "✓ All tests passed"
