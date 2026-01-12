#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/tcl:local}"

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

# Example 2: Variables and expressions
verify_fraglet "Sum:" <<'EOF'
set a 5
set b 10
set sum [expr $a + $b]
puts "Sum: $sum"
EOF

# Example 3: Procedure definition
verify_fraglet "Hello, Alice!" <<'EOF'
proc greet {name} {
    return "Hello, $name!"
}

puts [greet "Alice"]
EOF

# Example 4: List processing
verify_fraglet "Total:" <<'EOF'
set numbers {1 2 3 4 5}
set total 0
foreach num $numbers {
    set total [expr $total + $num]
}
puts "Total: $total"
EOF

# Example 5: String manipulation
verify_fraglet "Uppercase:" <<'EOF'
set text "hello world"
set upper [string toupper $text]
puts "Uppercase: $upper"
EOF

# Example 6: Conditional logic
verify_fraglet "Grade: B" <<'EOF'
set score 85
if {$score >= 90} {
    puts "Grade: A"
} elseif {$score >= 80} {
    puts "Grade: B"
} else {
    puts "Grade: C"
}
EOF

echo "✓ All tests passed"
