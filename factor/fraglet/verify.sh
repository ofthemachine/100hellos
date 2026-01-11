#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/factor:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    cat | fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello, World!" <<'EOF'
USING: io ;
"Hello, World!" print
EOF

# Example 2: Stack arithmetic
verify_fraglet "8" <<'EOF'
USING: io math ;
5 3 + number>string print
EOF

# Example 3: String concatenation
verify_fraglet "Hello World!" <<'EOF'
USING: io sequences ;
"Hello" " " "World!" 3append print
EOF

# Example 4: Using quotations
verify_fraglet "10" <<'EOF'
USING: io math ;
5 [ 2 * ] call number>string print
EOF

# Example 5: Stack manipulation
verify_fraglet "100" <<'EOF'
USING: io math ;
10 dup * number>string print
EOF

# Example 6: Multiple operations
verify_fraglet "20" <<'EOF'
USING: io math ;
2 3 + 4 * number>string print
EOF

# Example 7: Using vocabularies
verify_fraglet "2.0" <<'EOF'
USING: io math.functions ;
4 sqrt number>string print
EOF

# Example 8: Combinators
verify_fraglet "{ 2 4 6 8 10 }" <<'EOF'
USING: sequences prettyprint ;
{ 1 2 3 4 5 } [ 2 * ] map .
EOF

echo "✓ All tests passed"
