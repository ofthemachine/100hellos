#!/bin/bash
# verify.sh - Smoke tests for ATS fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/ats:local}"

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
implement main0 () =
  print ("Hello from fragment!\n")
EOF

# Example 2: Variables
verify_fraglet "Variables work" <<'EOF'
implement main0 () =
  let
    val message = "Variables work\n"
  in
    print (message)
  end
EOF

# Example 3: Conditional output
verify_fraglet "Condition is true" <<'EOF'
implement main0 () =
  if true then
    print ("Condition is true\n")
  else
    print ("Condition is false\n")
EOF

# Example 4: Multiple print statements
verify_fraglet "First line" <<'EOF'
implement main0 () =
  (print ("First line\n"); print ("Second line\n"); print ("Third line\n"))
EOF

echo "✓ All tests passed"
