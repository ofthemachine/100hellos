#!/bin/bash
# verify.sh - Smoke tests for Elixir fraglet support
set -euo pipefail
IMAGE="${1:-100hellos/elixir:local}"
verify_fraglet() { local e="$1"; fragletc --image "$IMAGE" - 2>&1 | grep -q "$e"; }
echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"
echo "Testing fraglet examples..."
verify_fraglet "Hello, World!" <<'EOF'
IO.puts("Hello, World!")
EOF
verify_fraglet "Hello, Alice" <<'EOF'
defmodule Greet do
  def greet(name), do: "Hello, #{name}!"
end
IO.puts(Greet.greet("Alice"))
EOF
echo "✓ All tests passed"
