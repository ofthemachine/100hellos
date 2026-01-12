#!/bin/bash
# verify.sh - Smoke tests for sed fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/sed:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello from fragment!" <<'EOF'
1s/^/Hello from fragment!/
EOF

# Example 2: Multiple substitutions
verify_fraglet "Hello" <<'EOF'
1s/^/Hello /; 1s/$/ World!/
EOF

# Example 3: Append text
verify_fraglet "This is appended text" <<'EOF'
a\This is appended text
EOF

# Example 4: Insert text
verify_fraglet "This is inserted text" <<'EOF'
i\This is inserted text
EOF

# Example 5: Substitute with case-insensitive flag (first add text, then substitute)
verify_fraglet "HELLO" <<'EOF'
1s/^/hello world/; 1s/hello/HELLO/gi
EOF

# Example 6: Multiple commands on same line
verify_fraglet "Prefix" <<'EOF'
1s/^/Prefix /; 1s/$/ Suffix/
EOF

# Example 7: Pattern-based substitution (first add text, then substitute)
verify_fraglet "REPLACED" <<'EOF'
1s/^/Hello World/; /Hello/s/Hello/REPLACED/
EOF

# Example 8: Creative formatting - transform list into formatted output
verify_fraglet "Colors:" <<'EOF'
1s/^/Colors: /; 2s/^/  * /; 3s/^/  * /; 3s/$/ (favorite)/
EOF

echo "✓ All tests passed"
