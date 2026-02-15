#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for ArnoldC fraglet.
# ArnoldC only supports reading integers (I WANT TO ASK YOU A BUNCH OF QUESTIONS...).
set -euo pipefail
IMAGE="${1:-100hellos/arnoldc:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.arnoldc"
cat > "$tmp" <<'EOF'
IT'S SHOWTIME
  HEY CHRISTMAS TREE n
  YOU SET US UP 0
  GET YOUR ASS TO MARS n
  DO IT NOW
  I WANT TO ASK YOU A BUNCH OF QUESTIONS AND I WANT TO HAVE THEM ANSWERED IMMEDIATELY
  TALK TO THE HAND n
YOU HAVE BEEN TERMINATED
EOF
echo "42" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "42"
echo "✓ stdin verified"
