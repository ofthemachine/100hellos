#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Vala fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/vala:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.vala"
cat > "$tmp" <<'EOF'
void main(string[] args) {
    string[] a = args[1:args.length];
    print("Args: " + string.joinv(" ", a) + "\n");
}
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
