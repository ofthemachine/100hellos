#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/cpp:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.cpp"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
cat > "$tmp" <<'EOF'
#include <iostream>
int main() {
    std::cout << "Hello from fragment!" << std::endl;
    return 0;
}
EOF
verify_fraglet "Hello from fragment!"

# Example 2: Variables and calculations
cat > "$tmp" <<'EOF'
#include <iostream>
int main() {
    int a = 5;
    int b = 10;
    std::cout << "Sum: " << (a + b) << std::endl;
    return 0;
}
EOF
verify_fraglet "Sum: 15"

# Example 3: Using STL vector
cat > "$tmp" <<'EOF'
#include <iostream>
#include <vector>
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
verify_fraglet "Vector sum: 15"

# Example 4: String operations
cat > "$tmp" <<'EOF'
#include <iostream>
#include <string>
int main() {
    std::string message = "Hello";
    message += " World!";
    std::cout << message << std::endl;
    return 0;
}
EOF
verify_fraglet "Hello World!"

# Example 5: Simple class
cat > "$tmp" <<'EOF'
#include <iostream>
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
verify_fraglet "5 + 3 = 8"

# Example 6: Template function
cat > "$tmp" <<'EOF'
#include <iostream>
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
verify_fraglet "Max(5, 10) = 10"

echo "✓ All tests passed"
