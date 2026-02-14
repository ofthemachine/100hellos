#!/bin/bash
# verify.sh - Smoke tests for Scala fraglet support
# Uses temp files for code (fragletc does not read code from stdin).
# Contract: default run, guide examples, stdin, args.

set -euo pipefail

IMAGE="${1:-100hellos/scala:local}"
EXT=".scala"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output (full object Main)
cat > "$tmp" <<'EOF'
object Main {
  def main(args: Array[String]): Unit = {
    println("Hello, World!")
  }
}
EOF
verify_fraglet "Hello, World!"

# Example 2: Function and greet
cat > "$tmp" <<'EOF'
object Main {
  def main(args: Array[String]): Unit = {
    def greet(name: String): String = s"Hello, $name!"
    println(greet("Alice"))
  }
}
EOF
verify_fraglet "Hello, Alice!"

# Example 3: List processing
cat > "$tmp" <<'EOF'
object Main {
  def main(args: Array[String]): Unit = {
    val numbers = List(1, 2, 3, 4, 5)
    val squared = numbers.map(x => x * x)
    println(s"Sum of squares: ${squared.sum}")
  }
}
EOF
verify_fraglet "Sum of squares"

# Stdin test
echo "Testing stdin..."
cat > "$tmp" <<'EOF'
object Main {
  def main(args: Array[String]): Unit = {
    scala.io.Source.stdin.getLines().foreach(line => println(line.toUpperCase))
  }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"

# Argument passing
echo "Testing argument passing..."
cat > "$tmp" <<'EOF'
object Main {
  def main(args: Array[String]): Unit = {
    println("Args: " + args.mkString(" "))
  }
}
EOF
verify_fraglet "Args: foo bar baz" foo bar baz

echo "✓ All tests passed"
