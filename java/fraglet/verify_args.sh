#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Java fraglet.
# Contract: fragment receives args; fragletc passes them through.

set -euo pipefail

IMAGE="${1:-100hellos/java:local}"
EXT=".java"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

cat > "$tmp" <<'EOF'
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        System.out.println("Args: " + String.join(" ", args));
    }
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
