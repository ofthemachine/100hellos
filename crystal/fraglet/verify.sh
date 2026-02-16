#!/bin/bash
# verify.sh - Smoke tests for crystal fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/crystal:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.cr"

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
puts "Hello, World!"
EOF
verify_fraglet "Hello, World!"

# Example 2: Class with method
cat > "$tmp" <<'EOF'
class Greeting
  def greet(name : String)
    puts "Hello, #{name}!"
  end
end

g = Greeting.new
g.greet("Alice")
EOF
verify_fraglet "Hello, Alice"

# Example 3: Variables and arithmetic
cat > "$tmp" <<'EOF'
a = 5
b = 10
sum = a + b
puts "Sum: #{sum}"
EOF
verify_fraglet "Sum: 15"

# Example 4: Array processing
cat > "$tmp" <<'EOF'
numbers = [1, 2, 3, 4, 5]
squared = numbers.map { |x| x ** 2 }
puts "Sum of squares: #{squared.sum}"
EOF
verify_fraglet "Sum of squares: 55"

# Example 5: Method definition with type annotations
cat > "$tmp" <<'EOF'
def calculate(x : Int32, y : Int32) : Int32
  x * y + 10
end

result = calculate(5, 3)
puts "Result: #{result}"
EOF
verify_fraglet "Result: 25"

# Example 6: Struct example
cat > "$tmp" <<'EOF'
struct Point
  property x : Int32
  property y : Int32

  def initialize(@x, @y)
  end

  def distance : Float64
    Math.sqrt(@x ** 2 + @y ** 2)
  end
end

p = Point.new(3, 4)
puts "Distance: #{p.distance}"
EOF
verify_fraglet "Distance: 5.0"

echo "✓ All tests passed"
