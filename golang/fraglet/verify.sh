#!/bin/bash
# verify.sh - Smoke tests for Go fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/golang:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.go"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
import (
	"fmt"
)

func main() {
	fmt.Println("Hello from fragment!")
}
EOF
verify_fraglet "Hello from fragment!"

cat > "$tmp" <<'EOF'
import (
	"fmt"
)

func main() {
	a := 5
	b := 10
	fmt.Printf("Sum: %d\n", a+b)
}
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
import (
	"fmt"
)

func add(a, b int) int {
	return a + b
}

func main() {
	result := add(5, 10)
	fmt.Printf("5 + 10 = %d\n", result)
}
EOF
verify_fraglet "5 + 10 = 15"

cat > "$tmp" <<'EOF'
import (
	"fmt"
)

func main() {
	numbers := []int{1, 2, 3, 4, 5}
	sum := 0
	for _, num := range numbers {
		sum += num
	}
	fmt.Printf("Sum: %d\n", sum)
}
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
import (
	"fmt"
)

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
verify_fraglet "Alice is 30 years old"

cat > "$tmp" <<'EOF'
import (
	"fmt"
)

func main() {
	m := map[string]int{
		"apple":  5,
		"banana": 3,
	}
	fmt.Printf("Apples: %d\n", m["apple"])
}
EOF
verify_fraglet "Apples: 5"

cat > "$tmp" <<'EOF'
import (
	"fmt"
)

func main() {
	s := "Hello"
	s += " World!"
	fmt.Println(s)
}
EOF
verify_fraglet "Hello World!"

echo "✓ All tests passed"
