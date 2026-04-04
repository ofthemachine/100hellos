#!/bin/bash
# verify.sh - Smoke tests for Sol fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/sol:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.sl"

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
def main
   print("Hello from fragment!")
end
EOF
verify_fraglet "Hello from fragment!"

# Example 2: Variables and string interpolation
cat > "$tmp" <<'EOF'
def main
   name = "Sol"
   version = 1
   print("#{name} version #{version}")
end
EOF
verify_fraglet "Sol version 1"

# Example 3: Functions
cat > "$tmp" <<'EOF'
def add(a Int, b Int) -> Int
   -> a + b
end

def main
   result = add(5, 10)
   print("5 + 10 = #{result}")
end
EOF
verify_fraglet "5 + 10 = 15"

# Example 4: If-else expression
cat > "$tmp" <<'EOF'
def main
   x = 42
   label = if x > 0 { "positive" } else { "negative" }
   print("#{x} is #{label}")
end
EOF
verify_fraglet "42 is positive"

# Example 5: While loop
cat > "$tmp" <<'EOF'
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
verify_fraglet "Sum: 10"

# Example 6: Enums and pattern matching
cat > "$tmp" <<'EOF'
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
verify_fraglet "Color: red"

# Example 7: Hash maps
cat > "$tmp" <<'EOF'
def main
   scores = Hash.new()
   scores["alice"] = 95
   scores["bob"] = 87
   print("Alice: #{scores.get_or("alice", 0)}")
end
EOF
verify_fraglet "Alice: 95"

# Example 8: Array iterators
cat > "$tmp" <<'EOF'
def main
   numbers = [1, 2, 3, 4, 5]
   doubled = numbers.map({|x| x * 2})
   total = numbers.reduce(0, {|sum, x| sum + x})
   print("Doubled: #{doubled}")
   print("Sum: #{total}")
end
EOF
verify_fraglet "Sum: 15"

# Example 9: String operations
cat > "$tmp" <<'EOF'
def main
   text = "hello, world"
   print("Upper: #{text.to_uppercase()}")
   print("Replace: #{text.replace("world", "Sol")}")
end
EOF
verify_fraglet "Upper: HELLO, WORLD"

# Example 10: Recursion
cat > "$tmp" <<'EOF'
def factorial(n Int) -> Int
   if n <= 1 { -> 1 }
   -> n * factorial(n - 1)
end

def main
   print("10! = #{factorial(10)}")
end
EOF
verify_fraglet "10! = 3628800"

echo "✓ All tests passed"
