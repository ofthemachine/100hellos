#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Erlang fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/erlang:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.erl"
cat > "$tmp" <<'EOF'
-export([main/0]).

main() ->
    Args = init:get_plain_arguments(),
    io:format("Args: ~s~n", [string:join(Args, " ")]).
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
