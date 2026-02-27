#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Clojure fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/clojure:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.clj"
cat > "$tmp" <<'EOF'
(println "Args:" (clojure.string/join " " *command-line-args*))
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
