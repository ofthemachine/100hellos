#!/bin/bash
# verify.sh - Smoke tests for COBOL fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/cobol:local}"
EXT=".cob"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -Fq "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -Fq "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
cat > "$tmp" <<'EOF'
IDENTIFICATION DIVISION.
PROGRAM-ID. HELLO.
PROCEDURE DIVISION.
    DISPLAY "Hello, World!"
    STOP RUN.
EOF
verify_fraglet "Hello, World!"

# Example 2: Variables and calculations
cat > "$tmp" <<'EOF'
IDENTIFICATION DIVISION.
PROGRAM-ID. GREET.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  A PIC 99 VALUE 5.
01  B PIC 99 VALUE 10.
PROCEDURE DIVISION.
    COMPUTE A = A + B
    DISPLAY "Sum: " A
    STOP RUN.
EOF
verify_fraglet "Sum:"

# Example 3: Sum of squares
cat > "$tmp" <<'EOF'
IDENTIFICATION DIVISION.
PROGRAM-ID. SQUARES.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  I PIC 99.
01  S PIC 999 VALUE ZERO.
01  N PIC 99 VALUE 5.
PROCEDURE DIVISION.
    PERFORM VARYING I FROM 1 BY 1 UNTIL I > N
        COMPUTE S = S + I * I
    END-PERFORM
    DISPLAY "Sum of squares: " S
    STOP RUN.
EOF
verify_fraglet "Sum of squares"

echo "✓ All tests passed"
