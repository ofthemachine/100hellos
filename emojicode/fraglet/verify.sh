#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/emojicode:local}"
EXT=".emojic"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
🏁 🍇
  😀 🔤Hello World!🔤❗️
🍉
EOF
verify_fraglet "Hello World!"

cat > "$tmp" <<'EOF'
🏁 🍇
  😀 🔤First line🔤❗️
  😀 🔤Second line🔤❗️
🍉
EOF
verify_fraglet "First line"
verify_fraglet "Second line"

echo "✓ All tests passed"
