#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/kotlin:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.kt"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -Fq "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -Fq "Hello World!!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    println("Hello, World!")
}
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    fun greet(name: String): String {
        return "Hello, $name!"
    }
    println(greet("Alice"))
}
EOF
verify_fraglet "Hello, Alice!"

cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    val numbers = listOf(1, 2, 3, 4, 5)
    val squared = numbers.map { it * it }
    println("Sum of squares: ${squared.sum()}")
}
EOF
verify_fraglet "Sum of squares:"

cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    val multiply = { a: Int, b: Int -> a * b }
    println("5 * 3 = ${multiply(5, 3)}")
}
EOF
verify_fraglet "5 * 3 = 15"

cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    class Calculator {
        fun add(a: Int, b: Int): Int {
            return a + b
        }
    }
    val calc = Calculator()
    println("10 + 20 = ${calc.add(10, 20)}")
}
EOF
verify_fraglet "10 + 20 = 30"

cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    val name = "Kotlin"
    val version = 1.9
    println("Welcome to $name $version!")
}
EOF
verify_fraglet "Welcome to Kotlin"

cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    data class Person(val name: String, val age: Int)
    val person = Person("Bob", 30)
    println("${person.name} is ${person.age} years old")
}
EOF
verify_fraglet "Bob is 30 years old"

cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    val name: String? = "Kotlin"
    name?.let { println("Name: $it") }
    val nullable: String? = null
    println(nullable ?: "Default value")
}
EOF
verify_fraglet "Name: Kotlin"

cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    fun String.double(): String = this + this
    val text = "Hello"
    println(text.double())
}
EOF
verify_fraglet "HelloHello"

cat > "$tmp" <<'EOF'
fun main(args: Array<String>) {
    val x = 5
    val result = when {
        x < 0 -> "negative"
        x == 0 -> "zero"
        else -> "positive"
    }
    println("x is $result")
}
EOF
verify_fraglet "x is positive"

echo "✓ All tests passed"
