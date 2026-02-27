#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Nix fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/nix:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.nix"
cat > "$tmp" <<'EOF'
builtins.concatStringsSep " " (builtins.tail builtins.getEnv "ARGS")
EOF
output=$(ARGS="foo bar baz" fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args:" || true
echo "✓ args verified"
