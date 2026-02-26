#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Dart fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/dart:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.dart"
cat > "$tmp" <<'EOF'
import 'dart:io';
void main() {
  while (true) {
    var line = stdin.readLineSync();
    if (line == null) break;
    print(line.toUpperCase());
  }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
