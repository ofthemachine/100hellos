#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Pascal fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/pascal:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.pas"
cat > "$tmp" <<'EOF'
var
  i: integer;
begin
  write('Args:');
  for i := 1 to paramcount do
    write(' ', paramstr(i));
  writeln;
end.
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
