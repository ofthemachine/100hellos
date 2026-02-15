#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Ada fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/ada:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.adb"
cat > "$tmp" <<'EOF'
  Put ("Args: ");
  for I in 1 .. Ada.Command_Line.Argument_Count loop
    if I > 1 then Put (" "); end if;
    Put (Ada.Command_Line.Argument (I));
  end loop;
  New_Line;
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
