#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/hare:local}"

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
export fn main() void = {
    fmt::println("Hello from fragment!")!;
};
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
export fn main() void = {
    let a: int = 5;
    let b: int = 10;
    fmt::printfln("Sum: {}", a + b)!;
};
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
fn add(a: int, b: int) int = a + b;

export fn main() void = {
    let result = add(5, 10);
    fmt::printfln("5 + 10 = {}", result)!;
};
EOF

# Example 4: Slices and loops
verify_fraglet "Sum: 15" <<'EOF'
export fn main() void = {
    let numbers: []int = [1, 2, 3, 4, 5];
    let sum = 0;
    for (let i = 0z; i < len(numbers); i += 1) {
        sum += numbers[i];
    };
    fmt::printfln("Sum: {}", sum)!;
};
EOF

# Example 5: Structs
verify_fraglet "Alice is 30 years old" <<'EOF'
type person = struct {
    name: str,
    age: int,
};

export fn main() void = {
    let p = person {
        name = "Alice",
        age = 30,
    };
    fmt::printfln("{} is {} years old", p.name, p.age)!;
};
EOF

# Example 6: String operations
verify_fraglet "Hello World!" <<'EOF'
export fn main() void = {
    let s = "Hello";
    fmt::printfln("{} World!", s)!;
};
EOF

# Example 7: Option types
verify_fraglet "Value: 42" <<'EOF'
fn maybe_value() (int | void) = 42;

export fn main() void = {
    match (maybe_value()) {
    case let v: int =>
        fmt::printfln("Value: {}", v)!;
    case void =>
        fmt::println("No value")!;
    };
};
EOF

echo "✓ All tests passed"
