#!/bin/bash
# verify_args.sh - Verified capability: argument passing for F# fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/fsharp:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.fsx"
cat > "$tmp" <<'EOF'
open System
let args = Environment.GetCommandLineArgs()[2..]  // [0]=runtime [1]=script
printfn "Args: %s" (String.Join(" ", args))
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
