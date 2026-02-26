#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Fortran fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/fortran:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.f90"
cat > "$tmp" <<'EOF'
program main
    character(256) :: line
    do
        read(*, '(a)', iostat=io) line
        if (io /= 0) exit
        call upper_case(line)
        print *, trim(line)
    end do
contains
    subroutine upper_case(s)
        character(*), intent(inout) :: s
        integer i
        do i = 1, len_trim(s)
            if (s(i:i) >= 'a' .and. s(i:i) <= 'z') s(i:i) = achar(iachar(s(i:i)) - 32)
        end do
    end subroutine
end program
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
