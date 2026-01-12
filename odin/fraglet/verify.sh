#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/odin:local}"

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
main :: proc() {
    fmt.println("Hello from fragment!")
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
main :: proc() {
    a: int = 5
    b: int = 10
    fmt.printf("Sum: %d\n", a + b)
}
EOF

# Example 3: Procedures
verify_fraglet "5 + 10 = 15" <<'EOF'
add :: proc(a, b: int) -> int {
    return a + b
}

main :: proc() {
    result := add(5, 10)
    fmt.printf("5 + 10 = %d\n", result)
}
EOF

# Example 4: Arrays and loops
verify_fraglet "Sum: 15" <<'EOF'
main :: proc() {
    numbers := []int{1, 2, 3, 4, 5}
    sum := 0
    for num in numbers {
        sum += num
    }
    fmt.printf("Sum: %d\n", sum)
}
EOF

# Example 5: Structs
verify_fraglet "Alice is 30 years old" <<'EOF'
Person :: struct {
    name: string,
    age:  int,
}

main :: proc() {
    p := Person{name = "Alice", age = 30}
    fmt.printf("%s is %d years old\n", p.name, p.age)
}
EOF

# Example 6: Maps
verify_fraglet "Apples: 5" <<'EOF'
main :: proc() {
    m := make(map[string]int)
    m["apple"] = 5
    m["banana"] = 3
    fmt.printf("Apples: %d\n", m["apple"])
}
EOF

# Example 7: String operations
verify_fraglet "Hello" <<'EOF'
main :: proc() {
    s := "Hello"
    s2 := " World!"
    fmt.println(s)
    fmt.println(s2)
}
EOF

# Example 8: Type inference and multiple return values
verify_fraglet "Result: 5" <<'EOF'
divide :: proc(a, b: int) -> (int, bool) {
    if b == 0 {
        return 0, false
    }
    return a / b, true
}

main :: proc() {
    result, ok := divide(10, 2)
    if ok {
        fmt.printf("Result: %d\n", result)
    } else {
        fmt.println("Division by zero!")
    }
}
EOF

echo "✓ All tests passed"
