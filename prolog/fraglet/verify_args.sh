#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/prolog:local}"
EXT=".pl"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
:- current_prolog_flag(argv, Args),
   atomic_list_concat(Args, ' ', Joined),
   format("Args: ~w~n", [Joined]).
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
