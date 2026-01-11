#!/bin/bash
# verify.sh - Smoke tests for Janet fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/janet:local}"

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
(defn greet [name]
  (string "Hello, " name "!"))

(print (greet "Alice"))
EOF

# Example 3: Array processing
verify_fraglet "Squared:" <<'EOF'
(def numbers [1 2 3 4 5])
(def squared (map |(* $ $) numbers))
(print "Squared:" squared)
EOF

# Example 4: Filter
verify_fraglet "Evens:" <<'EOF'
(def evens (filter even? [1 2 3 4 5 6 7 8 9 10]))
(print "Evens:" evens)
EOF

# Example 5: Reduce
verify_fraglet "Sum:" <<'EOF'
(def sum (reduce + 0 [1 2 3 4 5]))
(print "Sum:" sum)
EOF

# Example 6: Working with tables
verify_fraglet "Name:" <<'EOF'
(def person @{:name "Alice" :age 30})
(print "Name:" (get person :name))
(print "Age:" (get person :age))
EOF

# Example 7: String operations
verify_fraglet "HELLO WORLD" <<'EOF'
(print (string/ascii-upper "hello world"))
(print (string/join ["apple" "banana" "cherry"] ", "))
EOF

# Example 8: Function composition
verify_fraglet "Result:" <<'EOF'
(defn square [x] (* x x))
(defn add-one [x] (+ x 1))
(def result (map (comp add-one square) [1 2 3 4]))
(print "Result:" result)
EOF

echo "✓ All tests passed"
