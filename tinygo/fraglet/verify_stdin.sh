#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for TinyGo fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/tinygo:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.go"
cat > "$tmp" <<'EOF'
package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		fmt.Println(strings.ToUpper(scanner.Text()))
	}
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"
