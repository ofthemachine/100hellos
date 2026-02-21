#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for OCaml fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/ocaml:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ml"
cat > "$tmp" <<'EOF'
let () =
  try
    while true do
      let line = input_line stdin in
      print_endline (String.uppercase_ascii line)
    done
  with End_of_file -> ()
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
