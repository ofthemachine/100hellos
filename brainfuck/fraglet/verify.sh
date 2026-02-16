#!/bin/bash
# verify.sh - Smoke tests for Brainfuck fraglet support.

set -euo pipefail

IMAGE="${1:-100hellos/brainfuck:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.bf"

echo "Testing default execution..."
docker run --rm "$IMAGE" 2>&1 | grep -q "Hello World!"

echo "Testing fraglet (simple output)..."
# Print "Hi" (H=72, i=105 so +33 more after first .)
{ printf '+%.0s' $(seq 1 72); echo -n .; printf '+%.0s' $(seq 1 33); echo -n .; } > "$tmp"
fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "Hi"

echo "✓ All tests passed"
