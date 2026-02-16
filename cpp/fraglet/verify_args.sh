#!/bin/bash
# verify_args.sh - Verified capability: argument passing for C++ fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/cpp:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.cpp"
cat > "$tmp" <<'EOF'
#include <iostream>
int main(int argc, char *argv[]) {
    if (argc > 1) std::cout << "First: " << argv[1] << std::endl;
    if (argc > 2) std::cout << "Second: " << argv[2] << std::endl;
    return 0;
}
EOF
fragletc --image "$IMAGE" "$tmp" arg1 arg2 2>&1 | grep -q "First: arg1"
echo "✓ args verified"
