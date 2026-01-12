#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/rust:local}"

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
    println!("Hello from fragment!");
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
fn main() {
    let a = 5;
    let b = 10;
    println!("Sum: {}", a + b);
}
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
fn add(a: i32, b: i32) -> i32 {
    a + b
}

fn main() {
    let result = add(5, 10);
    println!("5 + 10 = {}", result);
}
EOF

# Example 4: Vectors and loops
verify_fraglet "Sum: 15" <<'EOF'
fn main() {
    let numbers = vec![1, 2, 3, 4, 5];
    let sum: i32 = numbers.iter().sum();
    println!("Sum: {}", sum);
}
EOF

# Example 5: Structs and methods
verify_fraglet "Alice is 30 years old" <<'EOF'
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

# Example 6: HashMaps
verify_fraglet "Apples: 5" <<'EOF'
use std::collections::HashMap;

fn main() {
    let mut m = HashMap::new();
    m.insert("apple", 5);
    m.insert("banana", 3);
    println!("Apples: {}", m["apple"]);
}
EOF

# Example 7: String operations
verify_fraglet "Hello World!" <<'EOF'
fn main() {
    let mut s = String::from("Hello");
    s.push_str(" World!");
    println!("{}", s);
}
EOF

# Example 8: Pattern matching with Option
verify_fraglet "Value: 42" <<'EOF'
fn main() {
    let maybe_value = Some(42);
    match maybe_value {
        Some(x) => println!("Value: {}", x),
        None => println!("No value"),
    }
}
EOF

# Example 9: Iterators
verify_fraglet "Doubled:" <<'EOF'
fn main() {
    let numbers = vec![1, 2, 3, 4, 5];
    let doubled: Vec<i32> = numbers.iter().map(|x| x * 2).collect();
    println!("Doubled: {:?}", doubled);
}
EOF

echo "✓ All tests passed"
