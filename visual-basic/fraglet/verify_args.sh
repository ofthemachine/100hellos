#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Visual Basic fraglet.

set -euo pipefail

IMAGE="${1:-100hellos/visual-basic:local}"
EXT=".vb"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
Module Fraglet
    Sub Main(args As String())
        Console.WriteLine("Args: " & String.Join(" ", args))
    End Sub
End Module
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -Fq "Args: foo bar baz"
echo "✓ args verified"
