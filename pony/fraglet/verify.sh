#!/bin/bash
# verify.sh - Smoke tests for pony fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/pony:local}"

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
actor Main
  new create(env: Env) =>
    env.out.print("Hello from fragment!")
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
actor Main
  new create(env: Env) =>
    let a: I32 = 5
    let b: I32 = 10
    env.out.print("Sum: " + (a + b).string())
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
actor Main
  new create(env: Env) =>
    env.out.print("5 + 10 = " + add(5, 10).string())

  fun add(a: I32, b: I32): I32 =>
    a + b
EOF

# Example 4: Arrays and loops
verify_fraglet "Sum: 15" <<'EOF'
actor Main
  new create(env: Env) =>
    let numbers: Array[I32] = [1; 2; 3; 4; 5]
    var sum: I32 = 0
    for num in numbers.values() do
      sum = sum + num
    end
    env.out.print("Sum: " + sum.string())
EOF

# Example 5: Classes
verify_fraglet "Alice is 30 years old" <<'EOF'
class Person
  var _name: String
  var _age: I32

  new create(name: String, age: I32) =>
    _name = name
    _age = age

  fun string(): String =>
    _name + " is " + _age.string() + " years old"

actor Main
  new create(env: Env) =>
    let p = Person("Alice", 30)
    env.out.print(p.string())
EOF

# Example 6: String operations
verify_fraglet "Hello World!" <<'EOF'
actor Main
  new create(env: Env) =>
    let s = "Hello"
    env.out.print(s + " World!")
EOF

# Example 7: Pattern matching
verify_fraglet "Two" <<'EOF'
actor Main
  new create(env: Env) =>
    let x: I32 = 2
    match x
    | 1 => env.out.print("One")
    | 2 => env.out.print("Two")
    else
      env.out.print("Other")
    end
EOF

echo "✓ All tests passed"
