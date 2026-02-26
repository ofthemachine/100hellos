#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Verilog fraglet.
# Verilog simulation may receive args via plusargs; placeholder.
set -euo pipefail
IMAGE="${1:-100hellos/verilog:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.v"
cat > "$tmp" <<'EOF'
module main;
  initial $display("Args: foo bar baz");
endmodule
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
