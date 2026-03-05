#!/bin/bash
# verify.sh - Smoke tests for sol fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/sol:local}"

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
def main
   print("Hello from fragment!")
end
EOF

# Example 2: Variables and string interpolation
verify_fraglet "Sol version 1" <<'EOF'
def main
   name = "Sol"
   version = 1
   print("#{name} version #{version}")
end
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
def add(a Int, b Int) -> Int
   -> a + b
end

def main
   result = add(5, 10)
   print("5 + 10 = #{result}")
end
EOF

# Example 4: If-else expression
verify_fraglet "42 is positive" <<'EOF'
def main
   x = 42
   label = if x > 0 { "positive" } else { "negative" }
   print("#{x} is #{label}")
end
EOF

# Example 5: While loop
verify_fraglet "Sum: 10" <<'EOF'
def main
   i = 0
   total = 0
   while i < 5 {
      total = total + i
      i = i + 1
   }
   print("Sum: #{total}")
end
EOF

# Example 6: Enums and pattern matching
verify_fraglet "Color: red" <<'EOF'
enum Color
   Red
   Green
   Blue
end

def main
   c = Color.Red
   name = match c {
      Red => "red",
      Green => "green",
      Blue => "blue"
   }
   print("Color: #{name}")
end
EOF

# Example 7: Recursion
verify_fraglet "10! = 3628800" <<'EOF'
def factorial(n Int) -> Int
   if n <= 1 { -> 1 }
   -> n * factorial(n - 1)
end

def main
   print("10! = #{factorial(10)}")
end
EOF

echo "✓ All tests passed"
