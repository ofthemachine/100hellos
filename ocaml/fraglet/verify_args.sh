#!/bin/bash
# verify_args.sh - Verified capability: argument passing for OCaml fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/ocaml:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ml"
cat > "$tmp" <<'EOF'
let () =
  let args = Array.to_list Sys.argv in
  let rest = List.tl args in
  Printf.printf "Args: %s\n" (String.concat " " rest)
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
