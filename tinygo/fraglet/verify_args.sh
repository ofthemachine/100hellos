#!/bin/bash
# verify_args.sh - Verified capability: argument passing for TinyGo fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/tinygo:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.go"
cat > "$tmp" <<'EOF'
package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	fmt.Println("Args:", strings.Join(os.Args[1:], " "))
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"
