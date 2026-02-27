#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Go fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/golang:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.go"
cat > "$tmp" <<'EOF'
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
output=$(echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1)
echo "$output" | grep -q "HELLO"
echo "✓ stdin verified"
