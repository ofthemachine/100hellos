#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Mercury fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/mercury:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.m"
cat > "$tmp" <<'EOF'
:- interface.
:- import_module io.
:- import_module string.
:- pred main(io::di, io::uo) is det.

:- implementation.
main(!IO) :-
    io.read_line(Res, !IO),
    (
        Res = ok(Line),
        string.to_upper(Line, Upper),
        io.write_string(Upper, !IO)
    ;
        Res = eof
    ;
        Res = error(_)
    ).
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
