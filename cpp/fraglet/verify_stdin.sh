#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for C++ fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/cpp:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.cpp"
cat > "$tmp" <<'EOF'
#include <iostream>
#include <cctype>
int main() {
    char c;
    while (std::cin.get(c)) std::cout << static_cast<char>(std::toupper(static_cast<unsigned char>(c)));
    return 0;
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
