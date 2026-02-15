#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for ATS fraglet.
# streamize_fileref_line(stdin_ref) reads lines; echo one line and grep.
set -euo pipefail
IMAGE="${1:-100hellos/ats:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.dats"
cat > "$tmp" <<'EOF'
implement main0() =
  let
    val lines = streamize_fileref_line(stdin_ref)
    val () = lines.foreach()(lam x => println!(x))
  in () end
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "hello"
echo "✓ stdin verified"
