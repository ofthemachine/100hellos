#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Mercury fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/mercury:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.m"
cat > "$tmp" <<'EOF'
:- interface.
:- import_module io.
:- import_module string.
:- import_module list.
:- pred main(io::di, io::uo) is det.

:- implementation.
main(!IO) :-
    io.command_line_arguments(Args, !IO),
    string.join_list(" ", Args, Joined),
    io.format("Args: %s\n", [s(Joined)], !IO).
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
