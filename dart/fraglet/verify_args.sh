#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Dart fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/dart:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.dart"
cat > "$tmp" <<'EOF'
void main(List<String> args) {
  print("Args: ${args.join(" ")}");
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
