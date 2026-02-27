#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Pony fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/pony:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.pony"
cat > "$tmp" <<'EOF'
actor Main
  new create(env: Env) =>
    let args = env.args.slice(1)
    env.out.print("Args: " + " ".join(args.values()))
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
