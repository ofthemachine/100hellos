#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Pony fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/pony:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.pony"
cat > "$tmp" <<'EOF'
actor Main
  new create(env: Env) =>
    env.out.print("Args: " + " ".join(env.args.values()))
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
