#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/r-project:local}"
EXT=".r"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
args <- commandArgs(trailingOnly = TRUE)
cat("Args:", paste(args, collapse = " "), "\n")
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
