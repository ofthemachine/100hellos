#!/bin/bash
# verify.sh - Smoke tests for crystal fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/crystal:local}"

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
puts "Hello, World!"
EOF

# Example 2: Class with method
verify_fraglet "Hello, Alice" <<'EOF'
class Greeting
  def greet(name : String)
    puts "Hello, #{name}!"
  end
end

g = Greeting.new
g.greet("Alice")
EOF

# Example 3: Variables and arithmetic
verify_fraglet "Sum: 15" <<'EOF'
a = 5
b = 10
sum = a + b
puts "Sum: #{sum}"
EOF

# Example 4: Array processing
verify_fraglet "Sum of squares: 55" <<'EOF'
numbers = [1, 2, 3, 4, 5]
squared = numbers.map { |x| x ** 2 }
puts "Sum of squares: #{squared.sum}"
EOF

# Example 5: Method definition with type annotations
verify_fraglet "Result: 25" <<'EOF'
def calculate(x : Int32, y : Int32) : Int32
  x * y + 10
end

result = calculate(5, 3)
puts "Result: #{result}"
EOF

# Example 6: Struct example
verify_fraglet "Distance: 5.0" <<'EOF'
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

echo "✓ All tests passed"
