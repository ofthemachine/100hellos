#!/bin/bash
# verify.sh - Smoke tests for Tcl fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/tcl:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.tcl"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
puts "Hello, World!"
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
set a 5
set b 10
set sum [expr $a + $b]
puts "Sum: $sum"
EOF
verify_fraglet "Sum:"

cat > "$tmp" <<'EOF'
proc greet {name} {
    return "Hello, $name!"
}

puts [greet "Alice"]
EOF
verify_fraglet "Hello, Alice!"

cat > "$tmp" <<'EOF'
set numbers {1 2 3 4 5}
set total 0
foreach num $numbers {
    set total [expr $total + $num]
}
puts "Total: $total"
EOF
verify_fraglet "Total:"

cat > "$tmp" <<'EOF'
set text "hello world"
set upper [string toupper $text]
puts "Uppercase: $upper"
EOF
verify_fraglet "Uppercase:"

cat > "$tmp" <<'EOF'
set score 85
if {$score >= 90} {
    puts "Grade: A"
} elseif {$score >= 80} {
    puts "Grade: B"
} else {
    puts "Grade: C"
}
EOF
verify_fraglet "Grade: B"

echo "✓ All tests passed"
