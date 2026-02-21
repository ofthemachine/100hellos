#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Kotlin fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/kotlin:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.kt"
cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    println("Args: ${args.joinToString(" ")}")
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
