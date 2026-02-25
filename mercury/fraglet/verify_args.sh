#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Mercury fraglet.
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
:- import_module string, list.

main(!IO) :-
    io.command_line_arguments(Args, !IO),
    string.join_list(" ", Args, Joined),
    io.format("Args: %s\n", [s(Joined)], !IO).
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
