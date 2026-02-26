#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Fortran fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/fortran:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.f90"
cat > "$tmp" <<'EOF'
program main
    use iso_fortran_env, only: command_argument_count, get_command_argument
    integer :: n, i
    character(256) :: arg
    n = command_argument_count()
    write(*, '(a)', advance='no') 'Args:'
    do i = 1, n
        call get_command_argument(i, arg)
        write(*, '(a)', advance='no') ' ' // trim(arg)
    end do
    print *
end program
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
