#!/bin/bash
# verify_args.sh - Verified capability: argument passing for COBOL fraglet.

set -euo pipefail

IMAGE="${1:-100hellos/cobol:local}"
EXT=".cob"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
IDENTIFICATION DIVISION.
PROGRAM-ID. ECHOARGS.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  CMD-LINE PIC X(512).
01  PROG-NAME PIC X(256).
01  ARGS-PART PIC X(256).
01  PTR PIC 9999.
01  REST-LEN PIC 9999.
01  SLASH-POS PIC 9999.
PROCEDURE DIVISION.
    ACCEPT CMD-LINE FROM COMMAND-LINE
    MOVE 1 TO PTR
    UNSTRING CMD-LINE DELIMITED BY SPACE
        INTO PROG-NAME WITH POINTER PTR
    END-UNSTRING
    MOVE 1 TO SLASH-POS
    INSPECT PROG-NAME TALLYING SLASH-POS
        FOR CHARACTERS BEFORE INITIAL "/"
    IF SLASH-POS < 256
        COMPUTE REST-LEN = 512 - PTR + 1
        MOVE CMD-LINE(PTR:REST-LEN) TO ARGS-PART
        DISPLAY "Args: " FUNCTION TRIM(ARGS-PART)
    ELSE
        DISPLAY "Args: " FUNCTION TRIM(CMD-LINE)
    END-IF
    STOP RUN.
EOF
fragletc --image "$IMAGE" "$tmp" arg1 arg2 2>&1 | grep -Fq "Args: arg1 arg2"
echo "✓ args verified"
