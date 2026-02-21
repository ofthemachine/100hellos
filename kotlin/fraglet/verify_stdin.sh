#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Kotlin fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/kotlin:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.kt"
cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    java.util.Scanner(System.`in`).use { scan ->
        while (scan.hasNextLine()) println(scan.nextLine().uppercase())
    }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
