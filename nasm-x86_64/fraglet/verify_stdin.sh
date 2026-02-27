#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/nasm-x86_64:local}"
EXT=".asm"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
sub       rsp, 64
mov       rax, 0
mov       rdi, 0
mov       rsi, rsp
mov       rdx, 64
syscall
mov       rdx, rax
mov       rax, 1
mov       rdi, 1
mov       rsi, rsp
syscall
add       rsp, 64
mov       rax, 60
xor       rdi, rdi
syscall
EOF
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "hello"
echo "✓ stdin verified"
