#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Ada fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/ada:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.adb"
cat > "$tmp" <<'EOF'
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Handling;

procedure Fraglet is
  Line : String (1 .. 1024);
  Last : Natural;
begin
  while not End_Of_File loop
    Get_Line (Line, Last);
    Put_Line (Ada.Characters.Handling.To_Upper (Line (1 .. Last)));
  end loop;
end Fraglet;
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
