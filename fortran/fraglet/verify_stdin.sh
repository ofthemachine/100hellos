#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Fortran fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/fortran:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.f90"
cat > "$tmp" <<'EOF'
  character(256) :: line
  integer :: io, ci
  read(*, '(a)', iostat=io) line
  do while (io == 0)
    do ci = 1, len_trim(line)
      if (line(ci:ci) >= 'a' .and. line(ci:ci) <= 'z') line(ci:ci) = achar(iachar(line(ci:ci)) - 32)
    end do
    print *, trim(line)
    read(*, '(a)', iostat=io) line
  end do
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
