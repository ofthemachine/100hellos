#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for COBOL fraglet.

set -euo pipefail

IMAGE="${1:-100hellos/cobol:local}"
EXT=".cob"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
IDENTIFICATION DIVISION.
PROGRAM-ID. STDINUPPER.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  WS-LINE PIC X(256).
PROCEDURE DIVISION.
    ACCEPT WS-LINE
    DISPLAY FUNCTION UPPER-CASE(FUNCTION TRIM(WS-LINE))
    STOP RUN.
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -Fq "HELLO"
echo "✓ stdin verified"
