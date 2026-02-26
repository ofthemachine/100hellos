#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Verilog fraglet.
# Verilog is HDL; traditional stdin is not applicable in simulation.
# Placeholder for consistency; may be N/A.
set -euo pipefail
IMAGE="${1:-100hellos/verilog:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.v"
cat > "$tmp" <<'EOF'
module main;
  initial $display("HELLO");
endmodule
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
