#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Ada fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/ada:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.adb"
cat > "$tmp" <<'EOF'
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;

procedure Fraglet is
begin
  Put ("Args:");
  for I in 1 .. Ada.Command_Line.Argument_Count loop
    Put (" " & Ada.Command_Line.Argument (I));
  end loop;
  New_Line;
end Fraglet;
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
