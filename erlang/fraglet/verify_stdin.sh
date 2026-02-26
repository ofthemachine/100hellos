#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Erlang fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/erlang:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.erl"
cat > "$tmp" <<'EOF'
-module(fraglet).
-export([main/0]).

main() ->
    case io:get_line("") of
        eof -> ok;
        Line -> io:format("~s", [string:uppercase(Line)]), main()
    end.
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
