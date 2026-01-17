#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/cpp:local}"

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
int main() {
    std::cout << "Hello from fragment!" << std::endl;
    return 0;
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
int main() {
    int a = 5;
    int b = 10;
    std::cout << "Sum: " << (a + b) << std::endl;
    return 0;
}
EOF

# Example 3: Using STL vector
verify_fraglet "Vector sum: 15" <<'EOF'
int main() {
    std::vector<int> numbers = {1, 2, 3, 4, 5};
    int sum = 0;
    for (int num : numbers) {
        sum += num;
    }
    std::cout << "Vector sum: " << sum << std::endl;
    return 0;
}
EOF

# Example 4: String operations
verify_fraglet "Hello World!" <<'EOF'
int main() {
    std::string message = "Hello";
    message += " World!";
    std::cout << message << std::endl;
    return 0;
}
EOF

# Example 5: Simple class
verify_fraglet "5 + 3 = 8" <<'EOF'
class Calculator {
public:
    int add(int a, int b) {
        return a + b;
    }
};

int main() {
    Calculator calc;
    std::cout << "5 + 3 = " << calc.add(5, 3) << std::endl;
    return 0;
}
EOF

# Example 6: Template function
verify_fraglet "Max(5, 10) = 10" <<'EOF'
template<typename T>
T maximum(T a, T b) {
    return (a > b) ? a : b;
}

int main() {
    std::cout << "Max(5, 10) = " << maximum(5, 10) << std::endl;
    std::cout << "Max(3.14, 2.71) = " << maximum(3.14, 2.71) << std::endl;
    return 0;
}
EOF

# Example 7: Argument passing
echo "Testing argument passing..."
fragletc --image "$IMAGE" - arg1 arg2 <<'EOF' 2>&1 | grep -q "First: arg1"
#include <iostream>
int main(int argc, char *argv[]) {
    if (argc > 1) std::cout << "First: " << argv[1] << std::endl;
    if (argc > 2) std::cout << "Second: " << argv[2] << std::endl;
    return 0;
}
EOF

echo "✓ All tests passed"
