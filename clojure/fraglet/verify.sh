#!/bin/bash
# verify.sh - Smoke tests for Clojure fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/clojure:local}"

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
(println "Hello, World!")
EOF

# Example 2: Function definition
verify_fraglet "Hello, Alice!" <<'EOF'
(defn greet [name]
  (str "Hello, " name "!"))

(println (greet "Alice"))
EOF

# Example 3: List processing with threading
verify_fraglet "Sum of squares:" <<'EOF'
(->> [1 2 3 4 5]
     (map #(* % %))
     (reduce +)
     (println "Sum of squares:"))
EOF

# Example 4: Map operations
verify_fraglet "Squared:" <<'EOF'
(def numbers [1 2 3 4 5])
(def squared (map #(* % %) numbers))
(println "Squared:" squared)
EOF

# Example 5: Filter and transform
verify_fraglet "Even squares:" <<'EOF'
(->> [1 2 3 4 5 6 7 8 9 10]
     (filter even?)
     (map #(* % %))
     (println "Even squares:"))
EOF

# Example 6: Working with maps
verify_fraglet "Name:" <<'EOF'
(def person {:name "Alice" :age 30})
(println "Name:" (:name person))
(println "Age:" (:age person))
EOF

# Example 7: String operations
verify_fraglet "HELLO WORLD" <<'EOF'
(require '[clojure.string :as str])
(println (str/upper-case "hello world"))
(println (str/join ", " ["apple" "banana" "cherry"]))
EOF

echo "✓ All tests passed"
