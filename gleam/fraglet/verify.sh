#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/gleam:local}"

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
pub fn main() {
  io.println("Hello, World!")
}
EOF

# Example 2: Function with parameters
verify_fraglet "Hello, Alice" <<'EOF'
pub fn main() {
  greet("Alice")
}

fn greet(name: String) {
  io.println("Hello, " <> name <> "!")
}
EOF

# Example 3: Pattern matching with custom type
verify_fraglet "Result:" <<'EOF'
import gleam/int

pub type Op {
  Add
  Multiply
}

pub fn main() {
  let result = calculate(Add, 5, 10)
  io.println("Result: " <> int.to_string(result))
}

fn calculate(op: Op, a: Int, b: Int) -> Int {
  case op {
    Add -> a + b
    Multiply -> a * b
  }
}
EOF

# Example 4: List processing with pipe operator
verify_fraglet "Sum of squares:" <<'EOF'
import gleam/list
pub fn main() {
  let numbers = [1, 2, 3, 4, 5]
  let sum = numbers
    |> list.map(fn(x) { x * x })
    |> list.fold(0, fn(acc, x) { acc + x })
  io.println("Sum of squares: " <> int.to_string(sum))
}
EOF

# Example 5: Recursion
verify_fraglet "Factorial of 5:" <<'EOF'
import gleam/int
pub fn main() {
  let result = factorial(5)
  io.println("Factorial of 5: " <> int.to_string(result))
}

fn factorial(n: Int) -> Int {
  case n {
    0 -> 1
    n -> n * factorial(n - 1)
  }
}
EOF

# Example 6: Multiple functions
verify_fraglet "Double 5:" <<'EOF'
import gleam/int
pub fn main() {
  io.println("Double 5: " <> int.to_string(double(5)))
  io.println("Triple 5: " <> int.to_string(triple(5)))
}

fn double(x: Int) -> Int {
  x * 2
}

fn triple(x: Int) -> Int {
  x * 3
}
EOF

# Example 7: Using Result type
verify_fraglet "Result:" <<'EOF'
import gleam/result
import gleam/int
pub fn main() {
  case divide(10, 2) {
    Ok(value) -> io.println("Result: " <> int.to_string(value))
    Error(_) -> io.println("Division by zero!")
  }
}

fn divide(a: Int, b: Int) -> Result(Int, String) {
  case b {
    0 -> Error("Cannot divide by zero")
    _ -> Ok(a / b)
  }
}
EOF

# Example 8: List comprehensions and filtering
verify_fraglet "Even numbers:" <<'EOF'
import gleam/list
import gleam/debug
pub fn main() {
  let numbers = [1, 2, 3, 4, 5, 6]
  let evens = list.filter(numbers, fn(x) { x % 2 == 0 })
  io.println("Even numbers: " <> debug.to_string(evens))
}
EOF

echo "✓ All tests passed"
