#!/bin/bash
# verify.sh - Smoke tests for Fennel fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/fennel:local}"

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
(print "Hello, World!")
EOF

# Example 2: Function definition
verify_fraglet "Hello, Alice!" <<'EOF'
(fn greet [name]
  (.. "Hello, " name "!"))

(print (greet "Alice"))
EOF

# Example 3: Table processing
verify_fraglet "Sum of squares:" <<'EOF'
(local numbers [1 2 3 4 5])
(local sum (accumulate [sum 0
                        i value (ipairs numbers)]
              (+ sum (* value value))))
(print (.. "Sum of squares: " sum))
EOF

# Example 4: Pattern matching
verify_fraglet "single digit" <<'EOF'
(fn classify [n]
  (match n
    0 "zero"
    1 "one"
    (where n (< n 10)) "single digit"
    _ "other"))

(print (classify 5))
EOF

# Example 5: Destructuring
verify_fraglet "1" <<'EOF'
(let [[first second & rest] [1 2 3 4 5]]
  (print first second))
EOF

# Example 6: Working with tables
verify_fraglet "Name: Alice" <<'EOF'
(local person {:name "Alice" :age 30})
(print (.. "Name: " (. person :name)))
EOF

# Example 7: String operations
verify_fraglet "HELLO WORLD" <<'EOF'
(print (string.upper "hello world"))
EOF

echo "✓ All tests passed"
