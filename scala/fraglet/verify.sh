#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/scala:local}"

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -Fq "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Hello, World!"
println("Hello, World!")
EOF

# Example 2: Function definition
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Hello, Alice!"
def greet(name: String): String = {
    s"Hello, $name!"
}

println(greet("Alice"))
EOF

# Example 3: List processing
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Sum of squares:"
val numbers = List(1, 2, 3, 4, 5)
val squared = numbers.map(x => x * x)
println(s"Sum of squares: ${squared.sum}")
EOF

# Example 4: Higher-order function
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "5 * 3 = 15"
val multiply = (a: Int, b: Int) => a * b
println(s"5 * 3 = ${multiply(5, 3)}")
EOF

# Example 5: Class definition
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "10 + 20 = 30"
class Calculator {
    def add(a: Int, b: Int): Int = {
        a + b
    }
}

val calc = new Calculator()
println(s"10 + 20 = ${calc.add(10, 20)}")
EOF

# Example 6: String interpolation
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Welcome to Scala"
val name = "Scala"
val version = 3
println(s"Welcome to $name $version!")
EOF

# Example 7: Case class
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Bob is 30 years old"
case class Person(name: String, age: Int)

val person = Person("Bob", 30)
println(s"${person.name} is ${person.age} years old")
EOF

# Example 8: Pattern matching
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "x is positive"
val x = 5
val result = x match {
    case n if n < 0 => "negative"
    case 0 => "zero"
    case _ => "positive"
}
println(s"x is $result")
EOF

# Example 9: For comprehension
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Doubled:"
val numbers = List(1, 2, 3, 4, 5)
val doubled = for (n <- numbers) yield n * 2
println(s"Doubled: ${doubled.mkString(", ")}")
EOF

# Example 10: Option handling
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "Name: Scala"
val name: Option[String] = Some("Scala")
name.foreach(n => println(s"Name: $n"))

val empty: Option[String] = None
println(empty.getOrElse("Default value"))
EOF

# Example 11: Extension methods (implicit class)
fragletc --image "$IMAGE" - <<'EOF' 2>&1 | grep -Fq "HelloHello"
implicit class StringOps(s: String) {
    def double(): String = s + s
}

val text = "Hello"
println(text.double())
EOF

echo "✓ All tests passed"
