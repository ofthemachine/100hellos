#!/bin/bash
# verify.sh - Smoke tests for Ceylon fraglet support (base + guide examples).
# Contract: default run, guide examples. Stdin/args in verify_stdin.sh / verify_args.sh.

set -euo pipefail

IMAGE="${1:-100hellos/ceylon:local}"
EXT=".ceylon"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -Fq "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" 2>/dev/null | grep -Fq "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
cat > "$tmp" <<'EOF'
shared void run() {
    print("Hello, World!");
}
EOF
verify_fraglet "Hello, World!"

# Example 2: Variables and calculations
cat > "$tmp" <<'EOF'
shared void run() {
    Integer a = 5;
    Integer b = 10;
    Integer sum = a + b;
    print("Sum: ``sum``");
}
EOF
verify_fraglet "Sum:"

# Example 3: Function definition
cat > "$tmp" <<'EOF'
String greet(String name) {
    return "Hello, ``name``!";
}

shared void run() {
    print(greet("Alice"));
}
EOF
verify_fraglet "Hello, Alice"

# Example 4: Arrays and loops
cat > "$tmp" <<'EOF'
shared void run() {
    Integer[] numbers = [1, 2, 3, 4, 5];
    variable Integer sum = 0;
    for (n in numbers) {
        sum += n;
    }
    print("Array sum: ``sum``");
}
EOF
verify_fraglet "Array sum:"

# Example 5: Multiple helper functions
cat > "$tmp" <<'EOF'
Integer add(Integer a, Integer b) {
    return a + b;
}

Integer multiply(Integer a, Integer b) {
    return a * b;
}

shared void run() {
    Integer result = multiply(add(2, 3), 4);
    print("Result: ``result``");
}
EOF
verify_fraglet "Result:"

# Example 6: String operations
cat > "$tmp" <<'EOF'
shared void run() {
    String text = "Hello, World!";
    print("Length: ``text.size``");
}
EOF
verify_fraglet "Length:"

# Example 7: Conditionals
cat > "$tmp" <<'EOF'
shared void run() {
    Integer score = 85;
    if (score >= 90) {
        print("Grade: A");
    } else if (score >= 80) {
        print("Grade: B");
    } else {
        print("Grade: C");
    }
}
EOF
verify_fraglet "Grade: B"

# Example 8: Iteration with indices
cat > "$tmp" <<'EOF'
shared void run() {
    String[] fruits = ["apple", "banana", "cherry"];
    for (i -> fruit in fruits.indexed) {
        print("``i``: ``fruit``");
    }
}
EOF
verify_fraglet "0: apple"

echo "✓ All tests passed"
