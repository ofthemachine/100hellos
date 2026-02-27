#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Chapel fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/chapel:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.chpl"
cat > "$tmp" <<'EOF'
proc main(args: [] string) {
    writeln("Args: ", " ".join(args[1..]));
}
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
