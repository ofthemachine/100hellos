#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Groovy fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/groovy:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.groovy"
cat > "$tmp" <<'EOF'
println "Args: ${args.join(' ')}"
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
