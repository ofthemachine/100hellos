#!/bin/bash
# verify.sh - Smoke tests for ATS fraglet support.
# Contract: default run, guide examples. Stdin/args in verify_stdin.sh / verify_args.sh.

set -euo pipefail

IMAGE="${1:-100hellos/ats:local}"
EXT=".dats"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
cat > "$tmp" <<'EOF'
implement main0 () =
  print ("Hello from fragment!\n")
EOF
verify_fraglet "Hello from fragment!"

# Example 2: Variables
cat > "$tmp" <<'EOF'
implement main0 () =
  let
    val message = "Variables work\n"
  in
    print (message)
  end
EOF
verify_fraglet "Variables work"

# Example 3: Conditional output
cat > "$tmp" <<'EOF'
implement main0 () =
  if true then
    print ("Condition is true\n")
  else
    print ("Condition is false\n")
EOF
verify_fraglet "Condition is true"

# Example 4: Multiple print statements
cat > "$tmp" <<'EOF'
implement main0 () =
  (print ("First line\n"); print ("Second line\n"); print ("Third line\n"))
EOF
verify_fraglet "First line"

echo "✓ All tests passed"
