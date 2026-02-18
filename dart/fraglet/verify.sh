#!/bin/bash
# verify.sh - Smoke tests for Dart fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/dart:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.dart"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
print("Hello, World!");
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
var a = 5;
var b = 10;
print("Sum: ${a + b}");
EOF
verify_fraglet "Sum:"

cat > "$tmp" <<'EOF'
String greet(String name) {
  return "Hello, $name!";
}
print(greet("Alice"));
EOF
verify_fraglet "Hello, Alice"

cat > "$tmp" <<'EOF'
var numbers = [1, 2, 3, 4, 5];
var squared = numbers.map((x) => x * x).toList();
var sum = squared.reduce((a, b) => a + b);
print("Sum of squares: $sum");
EOF
verify_fraglet "Sum of squares:"

cat > "$tmp" <<'EOF'
for (var i = 1; i <= 5; i++) {
  print("Count: $i");
}
EOF
verify_fraglet "Count:"

cat > "$tmp" <<'EOF'
var person = {"name": "Bob", "age": 30};
print("${person["name"]} is ${person["age"]} years old");
EOF
verify_fraglet "Bob is 30 years old"

echo "✓ All tests passed"
