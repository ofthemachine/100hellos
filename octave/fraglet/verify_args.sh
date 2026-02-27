#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/octave:local}"
EXT=".m"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
args = argv();
printf("Args:");
for i = 1:length(args)
    printf(" %s", args{i});
end
printf("\n");
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
