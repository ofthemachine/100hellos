#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Visual Basic fraglet.

set -euo pipefail

IMAGE="${1:-100hellos/visual-basic:local}"
EXT=".vb"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
Module Fraglet
    Sub Main(args As String())
        Console.WriteLine(Console.In.ReadToEnd())
    End Sub
End Module
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -Fq "hello"
echo "✓ stdin verified"
