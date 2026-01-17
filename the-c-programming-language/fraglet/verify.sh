#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/the-c-programming-language:local}"

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
#include <stdio.h>
int main() {
    printf("Hello from fragment!\n");
    return 0;
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
#include <stdio.h>
int main() {
    int a = 5;
    int b = 10;
    printf("Sum: %d\n", a + b);
    return 0;
}
EOF

# Example 3: Loops and arrays
verify_fraglet "Array sum: 15" <<'EOF'
#include <stdio.h>
int main() {
    int numbers[] = {1, 2, 3, 4, 5};
    int sum = 0;
    for (int i = 0; i < 5; i++) {
        sum += numbers[i];
    }
    printf("Array sum: %d\n", sum);
    return 0;
}
EOF

# Example 4: String manipulation
verify_fraglet "Length: 13" <<'EOF'
#include <stdio.h>
#include <string.h>
int main() {
    char message[] = "Hello, World!";
    int len = strlen(message);
    printf("Length: %d\n", len);
    return 0;
}
EOF

# Example 5: Dynamic memory
verify_fraglet "Freed" <<'EOF'
#include <stdio.h>
#include <stdlib.h>
int main() {
    int *arr = malloc(5 * sizeof(int));
    for (int i = 0; i < 5; i++) {
        arr[i] = i * 2;
    }
    free(arr);
    printf("Freed\n");
    return 0;
}
EOF

# Example 6: Math functions
verify_fraglet "Square root: 4.00" <<'EOF'
#include <stdio.h>
#include <math.h>
int main() {
    double result = sqrt(16.0);
    printf("Square root: %.2f\n", result);
    return 0;
}
EOF

# Example 7: Argument passing
echo "Testing argument passing..."
fragletc --image "$IMAGE" - arg1 arg2 <<'EOF' 2>&1 | grep -q "First: arg1"
#include <stdio.h>
int main(int argc, char *argv[]) {
    if (argc > 1) printf("First: %s\n", argv[1]);
    if (argc > 2) printf("Second: %s\n", argv[2]);
    return 0;
}
EOF

echo "✓ All tests passed"
