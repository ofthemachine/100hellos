#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/kotlin:local}"

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -Fq "Hello World!!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Hello, World!"
println("Hello, World!")
EOF

# Example 2: Function definition
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Hello, Alice!"
fun greet(name: String): String {
    return "Hello, $name!"
}

println(greet("Alice"))
EOF

# Example 3: List processing
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Sum of squares:"
val numbers = listOf(1, 2, 3, 4, 5)
val squared = numbers.map { it * it }
println("Sum of squares: ${squared.sum()}")
EOF

# Example 4: Lambda usage
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "5 * 3 = 15"
val multiply = { a: Int, b: Int -> a * b }
println("5 * 3 = ${multiply(5, 3)}")
EOF

# Example 5: Class definition
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "10 + 20 = 30"
class Calculator {
    fun add(a: Int, b: Int): Int {
        return a + b
    }
}

val calc = Calculator()
println("10 + 20 = ${calc.add(10, 20)}")
EOF

# Example 6: String interpolation
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Welcome to Kotlin"
val name = "Kotlin"
val version = 1.9
println("Welcome to $name $version!")
EOF

# Example 7: Data class
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Bob is 30 years old"
data class Person(val name: String, val age: Int)

val person = Person("Bob", 30)
println("${person.name} is ${person.age} years old")
EOF

# Example 8: Null-safety
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Name: Kotlin"
val name: String? = "Kotlin"
name?.let { println("Name: $it") }

val nullable: String? = null
println(nullable ?: "Default value")
EOF

# Example 9: Extension function
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "HelloHello"
fun String.double(): String = this + this

val text = "Hello"
println(text.double())
EOF

# Example 10: When expression
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "x is positive"
val x = 5
val result = when {
    x < 0 -> "negative"
    x == 0 -> "zero"
    else -> "positive"
}
println("x is $result")
EOF

echo "✓ All tests passed"
