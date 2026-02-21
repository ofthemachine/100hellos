#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Java fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/java:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.java"
cat > "$tmp" <<'EOF'
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        java.util.Scanner s = new java.util.Scanner(System.in);
        while (s.hasNextLine()) {
            System.out.println(s.nextLine().toUpperCase());
        }
    }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
