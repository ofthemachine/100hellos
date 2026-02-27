#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Pascal fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/pascal:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.pas"
cat > "$tmp" <<'EOF'
var
  line: string;
begin
  while not eof do
  begin
    readln(line);
    writeln(upcase(line));
  end;
end.
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
