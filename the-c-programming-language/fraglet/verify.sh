#!/bin/bash
# verify.sh - Smoke tests for C fraglet support (base + guide examples).
# Contract: default run, guide examples. Stdin/args in verify_stdin.sh / verify_args.sh.

set -euo pipefail

IMAGE="${1:-100hellos/the-c-programming-language:local}"
EXT=".c"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

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
#include <stdio.h>
int main() {
    printf("Hello from fragment!\n");
    return 0;
}
EOF
verify_fraglet "Hello from fragment!"

# Example 2: Variables and calculations
cat > "$tmp" <<'EOF'
#include <stdio.h>
int main() {
    int a = 5;
    int b = 10;
    printf("Sum: %d\n", a + b);
    return 0;
}
EOF
verify_fraglet "Sum: 15"

# Example 3: Loops and arrays
cat > "$tmp" <<'EOF'
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
verify_fraglet "Array sum: 15"

# Example 4: String manipulation
cat > "$tmp" <<'EOF'
#include <stdio.h>
#include <string.h>
int main() {
    char message[] = "Hello, World!";
    int len = strlen(message);
    printf("Length: %d\n", len);
    return 0;
}
EOF
verify_fraglet "Length: 13"

# Example 5: Dynamic memory
cat > "$tmp" <<'EOF'
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
verify_fraglet "Freed"

# Example 6: Math functions
cat > "$tmp" <<'EOF'
#include <stdio.h>
#include <math.h>
int main() {
    double result = sqrt(16.0);
    printf("Square root: %.2f\n", result);
    return 0;
}
EOF
verify_fraglet "Square root: 4.00"

echo "✓ All tests passed"
