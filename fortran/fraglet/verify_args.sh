#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Fortran fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/fortran:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.f90"
cat > "$tmp" <<'EOF'
  integer :: n, i
  character(256) :: arg
  n = iargc()
  write(*, '(a)', advance='no') 'Args:'
  do i = 1, n
    call getarg(i, arg)
    write(*, '(a)', advance='no') ' ' // trim(arg)
  end do
  print *
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"
