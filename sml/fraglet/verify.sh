#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/sml:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello, World!" <<'EOF'
print "Hello, World!\n";
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
val a = 5;
val b = 10;
print ("Sum: " ^ Int.toString (a + b) ^ "\n");
EOF

# Example 3: Function definition
verify_fraglet "5 + 10 = 15" <<'EOF'
fun add x y = x + y;
print ("5 + 10 = " ^ Int.toString (add 5 10) ^ "\n");
EOF

# Example 4: Pattern matching
verify_fraglet "Factorial of 5: 120" <<'EOF'
fun factorial 0 = 1
  | factorial n = n * factorial (n - 1);
print ("Factorial of 5: " ^ Int.toString (factorial 5) ^ "\n");
EOF

# Example 5: Lists and higher-order functions
verify_fraglet "Sum:" <<'EOF'
val numbers = [1, 2, 3, 4, 5];
val sum = foldl (op +) 0 numbers;
print ("Sum: " ^ Int.toString sum ^ "\n");
EOF

# Example 6: List comprehensions (using map)
verify_fraglet "Squares:" <<'EOF'
val squares = map (fn x => x * x) [1, 2, 3, 4, 5];
print ("Squares: " ^ String.concatWith ", " (map Int.toString squares) ^ "\n");
EOF

# Example 7: String operations
verify_fraglet "Hello World!" <<'EOF'
val s = "Hello";
val t = s ^ " World!";
print (t ^ "\n");
EOF

# Example 8: Guards and case expressions
verify_fraglet "Absolute of ~5: 5" <<'EOF'
fun absolute x = if x >= 0 then x else ~x;
print ("Absolute of ~5: " ^ Int.toString (absolute (~5)) ^ "\n");
EOF

echo "✓ All tests passed"
