#!/bin/bash
# verify.sh - Smoke tests for Rust fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/rust:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.rs"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
fn main() {
    println!("Hello from fragment!");
}
EOF
verify_fraglet "Hello from fragment!"

cat > "$tmp" <<'EOF'
fn main() {
    let a = 5;
    let b = 10;
    println!("Sum: {}", a + b);
}
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
fn add(a: i32, b: i32) -> i32 {
    a + b
}

fn main() {
    let result = add(5, 10);
    println!("5 + 10 = {}", result);
}
EOF
verify_fraglet "5 + 10 = 15"

cat > "$tmp" <<'EOF'
fn main() {
    let numbers = vec![1, 2, 3, 4, 5];
    let sum: i32 = numbers.iter().sum();
    println!("Sum: {}", sum);
}
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
struct Person {
    name: String,
    age: u32,
}

impl Person {
    fn new(name: String, age: u32) -> Self {
        Person { name, age }
    }

    fn greet(&self) {
        println!("{} is {} years old", self.name, self.age);
    }
}

fn main() {
    let p = Person::new("Alice".to_string(), 30);
    p.greet();
}
EOF
verify_fraglet "Alice is 30 years old"

cat > "$tmp" <<'EOF'
use std::collections::HashMap;

fn main() {
    let mut m = HashMap::new();
    m.insert("apple", 5);
    m.insert("banana", 3);
    println!("Apples: {}", m["apple"]);
}
EOF
verify_fraglet "Apples: 5"

cat > "$tmp" <<'EOF'
fn main() {
    let mut s = String::from("Hello");
    s.push_str(" World!");
    println!("{}", s);
}
EOF
verify_fraglet "Hello World!"

cat > "$tmp" <<'EOF'
fn main() {
    let maybe_value = Some(42);
    match maybe_value {
        Some(x) => println!("Value: {}", x),
        None => println!("No value"),
    }
}
EOF
verify_fraglet "Value: 42"

cat > "$tmp" <<'EOF'
fn main() {
    let numbers = vec![1, 2, 3, 4, 5];
    let doubled: Vec<i32> = numbers.iter().map(|x| x * 2).collect();
    println!("Doubled: {:?}", doubled);
}
EOF
verify_fraglet "Doubled:"

echo "✓ All tests passed"
