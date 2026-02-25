#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for F# fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/fsharp:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.fsx"
cat > "$tmp" <<'EOF'
open System
let rec readLines () =
    match Console.ReadLine() with
    | null -> ()
    | line -> printfn "%s" (line.ToUpper()); readLines ()
readLines ()
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
