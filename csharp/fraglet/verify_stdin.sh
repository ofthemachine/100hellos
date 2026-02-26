#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for C# fraglet.
# Contract: fragment reads stdin; pipe into fragletc and assert output.

set -euo pipefail

IMAGE="${1:-100hellos/csharp:local}"
EXT=".cs"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
Console.WriteLine(Console.In.ReadToEnd());
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "hello"
echo "✓ stdin verified"
