#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/snobol4:local}"
EXT=".sno"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
        RESULT = "Args:"
        I = 2
NEXT    ARG = HOST(2, I)             :F(DONE)
        RESULT = RESULT " " ARG
        I = I + 1                    :(NEXT)
DONE    OUTPUT = RESULT
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
