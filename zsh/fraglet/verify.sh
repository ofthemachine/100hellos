#!/bin/bash
# verify.sh - Smoke tests for zsh fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/zsh:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.zsh"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'END'
echo "Hello from fragment!"
END
verify_fraglet "Hello from fragment!"

cat > "$tmp" <<'END'
NAME="Alice"
echo "Hello, $NAME!"
END
verify_fraglet "Hello, Alice"

cat > "$tmp" <<'END'
A=5
B=10
SUM=$((A + B))
echo "Sum: $SUM"
END
verify_fraglet "Sum: 15"

cat > "$tmp" <<'END'
FRUITS=("apple" "banana" "cherry")
for fruit in "${FRUITS[@]}"; do
    echo "Fruit: $fruit"
done
END
verify_fraglet "Fruit: apple"

cat > "$tmp" <<'END'
if [[ "test" == "test" ]]; then
    echo "Testing mode"
else
    echo "Normal mode"
fi
END
verify_fraglet "Testing mode"

cat > "$tmp" <<'END'
greet() {
    local name="$1"
    echo "Hello, $name!"
}

greet "World"
END
verify_fraglet "Hello, World!"

cat > "$tmp" <<'END'
DATE=$(date)
echo "Current date: $DATE"
END
verify_fraglet "Current date:"

cat > "$tmp" <<'END'
for i in {1..5}; do
    echo "Count: $i"
done
END
verify_fraglet "Count: 1"

cat > "$tmp" <<'END'
typeset -A colors
colors[red]="#FF0000"
colors[green]="#00FF00"
echo "Red: ${colors[red]}"
END
verify_fraglet "Red: #FF0000"

cat > "$tmp" <<'END'
VAR=""
echo "Value: ${VAR:-default}"
END
verify_fraglet "Value: default"

cat > "$tmp" <<'END'
TEXT="Hello World"
echo "${TEXT#Hello }"
END
verify_fraglet "World"

echo "✓ All tests passed"
