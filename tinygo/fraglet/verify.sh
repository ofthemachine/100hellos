#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/tinygo:local}"

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
func main() {
    fmt.Println("Hello from fragment!")
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
func main() {
    a := 5
    b := 10
    fmt.Printf("Sum: %d\n", a+b)
}
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
func add(a, b int) int {
    return a + b
}

func main() {
    result := add(5, 10)
    fmt.Printf("5 + 10 = %d\n", result)
}
EOF

# Example 4: Slices and loops
verify_fraglet "Sum: 15" <<'EOF'
func main() {
    numbers := []int{1, 2, 3, 4, 5}
    sum := 0
    for _, num := range numbers {
        sum += num
    }
    fmt.Printf("Sum: %d\n", sum)
}
EOF

# Example 5: Structs and methods
verify_fraglet "Alice is 30 years old" <<'EOF'
type Person struct {
    Name string
    Age  int
}

func (p Person) String() string {
    return fmt.Sprintf("%s is %d years old", p.Name, p.Age)
}

func main() {
    p := Person{Name: "Alice", Age: 30}
    fmt.Println(p)
}
EOF

# Example 6: Maps
verify_fraglet "Apples: 5" <<'EOF'
func main() {
    m := map[string]int{
        "apple":  5,
        "banana": 3,
    }
    fmt.Printf("Apples: %d\n", m["apple"])
}
EOF

# Example 7: String operations
verify_fraglet "Hello World!" <<'EOF'
func main() {
    s := "Hello"
    s += " World!"
    fmt.Println(s)
}
EOF

echo "✓ All tests passed"
