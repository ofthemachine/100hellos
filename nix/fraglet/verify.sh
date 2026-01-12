#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/nix:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple string output
verify_fraglet "Hello from fragment!" <<'EOF'
"Hello from fragment!"
EOF

# Example 2: String interpolation with let binding
verify_fraglet "Hello Nix!" <<'EOF'
let name = "Nix"; in "Hello ${name}!"
EOF

# Example 3: Calculations
verify_fraglet "15" <<'EOF'
let a = 5; b = 10; in builtins.toString (a + b)
EOF

# Example 4: List operations
verify_fraglet "apple, banana, cherry" <<'EOF'
builtins.concatStringsSep ", " ["apple" "banana" "cherry"]
EOF

# Example 5: List mapping
verify_fraglet "2 4 6 8 10" <<'EOF'
builtins.concatStringsSep " " (builtins.map (x: builtins.toString (x * 2)) [1 2 3 4 5])
EOF

# Example 6: Attribute sets
verify_fraglet "Alice is 30 years old" <<'EOF'
let person = { name = "Alice"; age = 30; }; in "${person.name} is ${builtins.toString person.age} years old"
EOF

# Example 7: Functions
verify_fraglet "15" <<'EOF'
let add = a: b: a + b; in builtins.toString (add 5 10)
EOF

# Example 8: Conditional expressions
verify_fraglet "Yes" <<'EOF'
if true then "Yes" else "No"
EOF

# Example 9: Recursive attribute sets
verify_fraglet "3" <<'EOF'
let attrs = rec { a = 1; b = a + 1; c = a + b; }; in builtins.toString attrs.c
EOF

echo "✓ All tests passed"
