#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Mercury fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/mercury:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.m"
cat > "$tmp" <<'EOF'
:- module fraglet.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module string, list, char.

main(!IO) :-
    io.read_line(Res, !IO),
    (
        Res = ok(Line),
        string.to_upper(Line, Upper),
        io.write_string(Upper, !IO),
        main(!IO)
    ;
        Res = eof
    ;
        Res = error(_)
    ).
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
