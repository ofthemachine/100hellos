#!/bin/bash
# verify_args.sh - Verified capability: argument passing for ATS fraglet.
# main0{n}(argc, argv) and listize_argc_argv; binary is run with ./hello_world "$@".
set -euo pipefail
IMAGE="${1:-100hellos/ats:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.dats"
cat > "$tmp" <<'EOF'
implement main0{n}(argc, argv): void =
  let
    val args = listize_argc_argv(argc, argv)
  in
    list0_foreach(args, lam(arg) => println!(arg))
  end
EOF
fragletc --image "$IMAGE" "$tmp" "foo" "bar" 2>&1 | grep -q "foo"
echo "✓ args verified"
