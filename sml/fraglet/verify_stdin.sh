#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for SML fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/sml:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.sml"
cat > "$tmp" <<'EOF'
fun loop () =
    case TextIO.inputLine TextIO.stdIn of
        NONE => ()
      | SOME s => (print (String.map Char.toUpper s); loop ());
loop ();
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
